import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:background_downloader/background_downloader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:salamat/modules/downloads/download/bloc_v2/download_state.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/core/sqlite.dart';
import 'package:salamat/modules/lessons/models/lesson.dart';

class DownloadCubit2 extends Cubit<DownloadState2> {
  /// [REQUIRED]
  String link; // Link to the file to be downloaded
  String fileName; // Name of the file to be downloaded
  String localPath; // Local path used for storing the file
  /// [OPTIONAL]
  String? mbProgress; // Progress of the download in MB
  String? fileName2; // Used for saving the file with a different name
  bool showContentLength; // Whether to show the content length
  int? metaId; // Metadata ID used for storing and retrieving the file
  bool requestWithFileName; // Whether to request the file with its name
  DownloadCubit2({
    required this.link,
    required this.fileName,
    required this.localPath,
    this.fileName2,
    this.showContentLength = false,
    this.metaId,
    this.requestWithFileName = false,
  }) : super(InitialState());

  /// [GET_UPDATES_STREAM] Stream for listening to download updates
  Stream<TaskUpdate> get _updatesStream =>
      _sharedUpdatesStream ??= downloader.updates.asBroadcastStream();

  /// [INSTACNES]
  static final FileDownloader _sharedDownloader =
      FileDownloader(); // Shared FileDownloader instance
  final FileDownloader downloader =
      _sharedDownloader; // Downloader instance used for downloading the file
  static Stream<TaskUpdate>?
      _sharedUpdatesStream; // Stream for listening to download updates
  StreamSubscription<TaskUpdate>?
      _updatesSubscription; // Subscription for listening to download updates
  TaskStatus status = TaskStatus.notFound; // Status of the download
  Task? task; // Task for the download
  TaskRecord? taskRecord; // Task record for the download
  late AndroidDeviceInfo
      androidInfo; // Android device info used for checking the file permission

  /// [NORMAL]
  int? contentLength; // Length of the content by bytes
  int? mbContentLength; // Length of the content by MB
  static bool _downloaderConfigured =
      false; // Whether the downloader has been configured
  static bool _downloaderStarted = false; // Whether the downloader has started
  double progress = 0; // Progress of the download

  /// [INIT]
  void init() async {
    /// [CHECK_CONTENT_LENGTH]
    // Check the content length if needed
    if (showContentLength) {
      await getContentLength();
      getMbContentLength();
    }

    /// [FOUND_TASKS]
    // get the task from the database
    final List<TaskRecord> foundTasks = (await downloader.database.allRecords())
        .where(
          (element) => element.task.filename == fileName,
        )
        .toList();
    if (metaId != null) {
      try {
        ///get the file size from sqlite
        final res = await SqliteHelper.getLesson(metaId!);

        contentLength = res.first['file_size'];
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
    if (!_downloaderStarted) {
      downloader.start();
      _downloaderStarted = true;
    }

    if (!_downloaderConfigured) {
      await downloader.configure(
        globalConfig: [
          (Config.requestTimeout, const Duration(seconds: 100)),
        ],
        androidConfig: [
          (Config.runInForeground, Config.always),
        ],
      );
      _downloaderConfigured = true;
    }

    _updatesSubscription ??= _updatesStream.listen(listener);
  }

  /// [DISPOSE]
  @override
  Future<void> close() {
    /// [FOR_PREVENT_MEMORY_LEAKS]
    _updatesSubscription?.cancel();
    return super.close();
  }

  /// [CALCULATE_PROGRESS_IN_MB]
  // Method to calculate the progress in MB
  void calMbProgress() {
    if (mbContentLength != null) {
      mbProgress =
          '${((progress / 100) * mbContentLength!).toStringAsFixed(1)} / ${mbContentLength}MB';
    }
  }

  /// [LISTENER_FOR_DOWNLOAD_UPDATES]
  // listener for download updates
  void listener(TaskUpdate update) {
    if (update is TaskStatusUpdate) {
      log('task status show listener $status');

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

  /// [CHECK_PERMISSION]
  // Check the permission for the download
  static Future<bool> checkPermission() async {
    if (Platform.isIOS) return true;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
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

  /// [CHECK_AND_EMIT]
  // Check the status and emit the appropriate state
  void checkAndEmit(TaskStatus status1, double progress1) async {
    /// [PROGRESS_IN_MB]
    // Calculate the progress in MB
    progress = math.max(0, double.parse((progress1 * 100).toStringAsFixed(1)));
    calMbProgress();

    if (status1 == TaskStatus.notFound) {
      if (isClosed) return;
      emit(TaskNotFoundState());
    } else if (status1 == TaskStatus.enqueued) {
      if (isClosed) return;
      emit(QueuedState());
    } else if (status1 == TaskStatus.canceled) {
      if (isClosed) return;
      // dispose();
      emit(CanceledState());
    } else if (status1 == TaskStatus.failed) {
      if (isClosed) return;
      // dispose();
      emit(FailedState());
    } else if (status1 == TaskStatus.running) {
      if (isClosed) return;
      emit(RunningState());
      // listenNow();
    } else if (await File(localPath + fileName).exists() ||
        status1 == TaskStatus.complete) {
      if (isClosed) return;
      emit(CompleteState());
    }
  }

  /// [REQUEST_DOWNLOAD]
  // Request the download
  void requestDownload({bool showNot = true, Lesson? lessonModel}) async {
    if (state is RequestingState ||
        state is QueuedState ||
        state is RunningState) {
      return;
    }
    emit(RequestingState());

    if (!await checkPermission()) {
      emit(InitialState());
      return;
    }
    try {
      /// [GET_CONTENT_LENGTH]
      // Get the content length
      await getContentLength();
      getMbContentLength();

      /// [CONFIGURE_NOTIFICATION]
      // Configure the notification for the download
      try {
        downloader.configureNotification(
          running: TaskNotification(fileName, ''),
          canceled: TaskNotification(fileName, ''),
          complete: TaskNotification(fileName, ''),
          paused: TaskNotification(fileName, ''),
          error: TaskNotification(fileName, ''),
          progressBar: true,
        );
      } catch (error) {
        log('conf error $error');
      }

      /// [TASK]
      // Task for the download
      task = DownloadTask(
        url: link,
        filename: fileName,
        updates: Updates.statusAndProgress,
        baseDirectory: BaseDirectory.root,
        directory: localPath,
        displayName: fileName,
        allowPause: true,
      );
      final successfullyEnqueued = await downloader.enqueue(
        task!,
      );
      if (successfullyEnqueued) {
        if (lessonModel != null) {
          SqliteHelper.insertLesson(
              lessonModel, fileName2 ?? fileName, contentLength!);
        }
        if (isClosed) return;
        emit(QueuedState());
      }
    } catch (error) {
      log('error is $error');
      if (isClosed) return;
      emit(RequestingFailedState());
    }
  }

  /// [GET_CONTENT_LENGTH]
  // Get the content length
  Future<void> getContentLength() async {
    try {
      if (showContentLength == false) {
        return;
      }
      contentLength = int.parse((await Network.dio.headUri(Uri.parse(link)))
          .headers
          .map['content-length']!
          .first
          .toString());
    } catch (error) {
      log('error is $error');
    }
  }

  /// [GET_MB_CONTENT_LENGTH]
  // Get the content length in MB
  void getMbContentLength() {
    if (contentLength != null) {
      mbContentLength = contentLength! ~/ 1000000;
    }
  }

  /// [RETRY]
  // Retry the download
  void retry() async {
    emit(RetryingState());

    await checkPermission();

    try {
      await downloader.enqueue((task as DownloadTask));
    } catch (error) {
      if (isClosed) return;
      emit(RetriedFailedState());
    }
    if (isClosed) return;
    emit(RetriedState());
  }

  /// [CANCEL_DOWNLOAD]
  // Cancel the download
  void cancelDownload() async {
    emit(CancellingSate());
    try {
      await downloader.cancel((task as DownloadTask));
    } catch (error) {
      log('show the cancel error $error');
    }
    if (isClosed) return;
    emit(CanceledState());
  }

  /// [REMOVE_TASK]
  // Remove the task from the database
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
    if (isClosed) return;
    emit(TaskNotFoundState());
  }

  /// [DELETE_FILE]
  // Delete the file from the device
  void deleteFile() async {
    if (!await checkPermission()) {
      return;
    }
    await File(localPath + fileName).delete(recursive: true);
  }

  /// [DELETE_LESSON]
  // Delete the lesson from the database
  void deleteLesson(int lessonId) {
    SqliteHelper.deleteLesson(lessonId);
    removeTask();
  }

  /// [CANCEL_LESSON]
  // Cancel the lesson from the database
  void cancelLesson(int id) {
    SqliteHelper.deleteLesson(id);
    cancelDownload();
  }
}
