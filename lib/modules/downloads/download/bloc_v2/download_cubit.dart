import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:ui';

import 'package:background_downloader/background_downloader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:salamat/modules/downloads/download/bloc_v2/download_state.dart';

import '../../../../apis/network.dart';
import '../../../../core/sqlite.dart';
import '../../../lessons/models/lesson.dart';



class DownloadCubit2 extends Cubit<DownloadState2> {
  DownloadCubit2(
      {required this.link,
      required this.fileName,
      this.fileName2,
      required this.localPath,
      this.showContentLength = false,
      this.metaId,
      this.requestWithFileName = false})
      : super(InitialState());

   Task? task;
   TaskRecord? taskRecord;

  // late List<Task> tasks;
  bool requestWithFileName;
  String localPath;
  TaskStatus status = TaskStatus.notFound;
  double progress = 0;
  String? mbProgress;
  String link;
  String fileName;
  String? fileName2;
  int? contentLength;
  int? mbContentLength;
  int? metaId;
  bool showContentLength;
  late AndroidDeviceInfo androidInfo;
  FileDownloader downloader = FileDownloader();
  void calMbProgress() {
    if (mbContentLength != null) {
      mbProgress =
      "${((progress / 100) * mbContentLength!).toStringAsFixed(1)} / ${mbContentLength}MB";
    }
  }

  @override
  Future<void> close() {
    downloader.destroy();
   // clean up your resources here
    return super.close();   // then call the base class close
  }

  void listener(TaskUpdate update) {
    if (update is TaskStatusUpdate) {
      print("task status show listener ${status}");

      if (update.task.taskId == task?.taskId) {
        status = update.status;
        checkAndEmit(status, progress);
      }
    }
    if (update is TaskProgressUpdate) {
      if (update.task.taskId == task?.taskId) {
        progress = update.progress;
        checkAndEmit(status, progress);
      }
    }
  }


  void init() async {
    // print("show all the tasks ${(await downloader.allTasks()).last.filename}");
    // downloader.cancelAll();

    // await downloader.trackTasks();


    // print("hhhhdk${(await downloader.database.allRecordsWithStatus(TaskStatus.running)).toList().length}");

    List<TaskRecord> foundTasks =
    (await downloader.database.allRecords()).where((element) => element.task.filename == fileName,).toList();
    if (metaId != null) {
      try {

        ///get the file size from sqlite
        final res = await SqliteHelper.getLesson(metaId!);

        contentLength = res.first["file_size"];
        getMbContentLength();
      } catch (error) {
        //
      }
    }
    if (foundTasks.isNotEmpty) {
      task = foundTasks.last.task;
      taskRecord = foundTasks.last;
      status = foundTasks.last.status;
      progress = foundTasks.last.progress;

    }
    checkAndEmit(status, progress);

    downloader.updates.listen(listener);

    downloader.start();
  }

  static Future<bool> checkPermission() async {
    if (Platform.isIOS) return true;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt > 28) {
      return true;
    }
    final status = await ph.Permission.storage.status;
    if (status != ph.PermissionStatus.granted) {
      final result = await ph.Permission.storage.request();
      if (result == ph.PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  void checkAndEmit(TaskStatus status1, double progress1) async {
    print("hello hello $status1 $progress1  ${TaskStatus.running.index}");
    progress = math.max(0,double.parse((progress1*100).toStringAsFixed(1))) ;
    calMbProgress();
    if(status1 == TaskStatus.notFound){
      emit(TaskNotFoundState());

    }
    else if (status1 == TaskStatus.enqueued) {
      emit(QueuedState());
    } else if (status1 == TaskStatus.canceled) {
      // dispose();
      emit(CanceledState());
    } else if (status1 == TaskStatus.failed) {
      // dispose();
      emit(FailedState());
    } else if (status1 == TaskStatus.running) {
      emit(RunningState());
      // listenNow();
    } else if (await File(localPath + fileName).exists()|| status1 == TaskStatus.complete) {
      emit(CompleteState());
    }
  }


  void requestDownload(
      {bool showNot = true, Lesson? lessonModel}) async {
    emit(RequestingState());

    if (!await checkPermission()) {
      emit(InitialState());
      return;
    }
    try {
      await getContentLength();
      getMbContentLength();
      print("hello hi");



      try {


        downloader.configureNotification(
          running: TaskNotification(fileName,""),
          canceled: TaskNotification(fileName,""),
          complete: TaskNotification(fileName,""),
          paused: TaskNotification(fileName,""),
          error: TaskNotification(fileName,""),
          progressBar: true,
        );
      }catch(error){
        print("conf error $error");

      }

      task = DownloadTask(
        url: link,
        filename: fileName,
        updates: Updates.statusAndProgress,
        baseDirectory:BaseDirectory.root,
        directory: localPath,
        displayName: fileName,
        options: TaskOptions(),
        retries: 0,

        allowPause: true,




      );

      final successfullyEnqueued = await downloader.enqueue(task!,);
      if (successfullyEnqueued) {



        if (lessonModel != null) {
          SqliteHelper.insertLesson(
              lessonModel, fileName2 ?? fileName, contentLength!);
        }
        emit(QueuedState());
      }
    } catch (error) {
      print("error is $error");
      emit(RequestingFailedState());
    }
  }




  Future<void> getContentLength() async {
    try {
      if (showContentLength == false) {
        return;
      }
      contentLength = int.parse((await Network.dio.headUri(Uri.parse(link)))
          .headers
          .map["content-length"]!
          .first
          .toString());
    } catch (error) {
      print("errorr is $error");
    }
  }

  void getMbContentLength() {
    if (contentLength != null) {
      mbContentLength = contentLength! ~/ 1000000;
    }
  }

  void retry() async {


    emit(RetryingState());

    await checkPermission();

    try {
      await downloader.enqueue((task as DownloadTask));
    } catch (error) {
      emit(RetriedFailedState());
    }
    emit(RetriedState());
  }

  void cancelDownload() async {
    emit(CancellingSate());
    try {
      // await FlutterDownloader.cancel(taskId: taskId);
      await downloader.cancel(
        (task as DownloadTask),
      );
    } catch (error) {
      print("show the cancel error $error");
      //
    }
    emit(CanceledState());
  }

  void removeTask() async {
    emit(CancellingSate());
    try {
      await downloader.database.deleteRecordWithId(task!.taskId);
      deleteFile();
    } catch (error) {
      //
    } finally {
      deleteFile();
    }

    emit(TaskNotFoundState());
  }

  void deleteFile() async {
    if (!await checkPermission()) {
      return;
    }
    await File(localPath + fileName).delete(recursive: true);
  }

  void deleteLesson(int lessonId) {
    SqliteHelper.deleteLesson(lessonId);
    removeTask();
  }

  void cancelLesson(int id) {
    ///Remove lessons from Sqlite table
    SqliteHelper.deleteLesson(id);

    cancelDownload();
  }
}
