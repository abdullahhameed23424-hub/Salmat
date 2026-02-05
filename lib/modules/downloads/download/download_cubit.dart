// import 'dart:async';
// import 'dart:io';
// import 'dart:isolate';
// import 'dart:ui';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:salamat/apis/network.dart';
// import 'package:salamat/core/sqlite.dart';
// import 'package:salamat/modules/downloads/download/download_state.dart';
// import 'package:salamat/modules/lessons/models/lesson.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// @pragma('vm:entry-point')
// void downloadCallback(String id, int status, int progress) {
//   final SendPort send = IsolateNameServer.lookupPortByName(id)!;
//   send.send([id, status, progress]);
// }
//
// class DownloadCubit extends Cubit<DownloadState> {
//   DownloadCubit(
//       {required this.link,
//       required this.fileName,
//       this.fileName2,
//       required this.localPath,
//       this.showContentLength = false,
//       this.metaId,
//       this.requestWithFileName = false})
//       : super(InitialState());
//
//   late var taskId;
//   bool requestWithFileName;
//   String localPath;
//   DownloadTaskStatus status = DownloadTaskStatus.undefined;
//   int progress = 0;
//   String? mbProgress;
//   String link;
//   String fileName;
//   String? fileName2;
//   int? contentLength;
//   int? mbContentLength;
//   int? metaId;
//   bool showContentLength;
//   late AndroidDeviceInfo androidInfo;
//
//   void calMbProgress() {
//     if (mbContentLength != null) {
//       mbProgress =
//           "${((progress / 100) * mbContentLength!).toStringAsFixed(0)} / ${mbContentLength}MB";
//     }
//   }
//
//   Future<void> getContentLength() async {
//     try {
//
//       if (showContentLength == false) {
//         return;
//       }
//       contentLength = int.parse((await Network.dio.headUri(Uri.parse(link)))
//           .headers
//           .map["content-length"]!
//           .first
//           .toString());
//
//     } catch (error) {
//       print("error is content $error");
//     }
//   }
//
//   void getMbContentLength() {
//     if (contentLength != null) {
//       mbContentLength = contentLength! ~/ 1000000;
//     }
//   }
//
//   void init() async {
//     FlutterDownloader.registerCallback(downloadCallback);
//     try {
//       List<DownloadTask>? tasks;
//
//       tasks = await FlutterDownloader.loadTasksWithRawQuery(
//           query:
//               'SELECT * , MAX(time_created) FROM task WHERE file_name="$fileName"');
//
//       ///This code snippet is temporary because we have changed the dependent filename
//       ///first we were depend on YouTube video id, but now we depend on the lesson name
//       ///that comes from the server.
//       ///You can remove this if you don't have the case
//       if (fileName2 != null) {
//         final tasks2 = await FlutterDownloader.loadTasksWithRawQuery(
//             query:
//                 'SELECT * , MAX(time_created) FROM task WHERE file_name="$fileName2"');
//         if (tasks2 != null) {
//           fileName = fileName2!;
//           tasks = tasks2;
//         }
//       }
//
//       if (metaId != null) {
//         try {
//           ///get the file size from sqlite
//           final res = await SqliteHelper.getLesson(metaId!);
//
//           contentLength = res.first["file_size"];
//           getMbContentLength();
//         } catch (error) {
//           //
//         }
//       }
//
//       if (tasks == null || tasks.isEmpty) {
//         emit(TaskNotFoundState());
//       } else {
//         taskId = tasks[0].taskId;
//
//         ///We force to call listenNow because send port does not send messages to receive port
//         /// when download task is not changing. For icr when task in COMPLETE status.
//         listenNow(tasks[0].taskId, tasks[0].status.index, tasks[0].progress);
//
//         ///Register send port that send messages to the receive port. The port name is TASK ID
//         ///the send port will search for the port later by the task id in the
//         ///top level function downloadCallback to send messages
//
//         IsolateNameServer.registerPortWithName(_port.sendPort, tasks[0].taskId);
//
//         ///This is the receive port the receives messages from send port
//         _port.listen(
//           (message) {
//             listenNow(message[0], message[1], message[2]);
//           },
//         );
//       }
//     } catch (error) {
//       print("show the error $error");
//     }
//     await prepareSaveDir();
//   }
//
//   void dispose() {
//     IsolateNameServer.removePortNameMapping(taskId);
//     _port.close();
//   }
//
//   static Future<bool> checkPermission() async {
//     if (Platform.isIOS) return true;
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo;
//     androidInfo = await deviceInfo.androidInfo;
//
//     if (androidInfo.version.sdkInt > 28) {
//       return true;
//     }
//     final status = await Permission.storage.status;
//     if (status != PermissionStatus.granted) {
//       final result = await Permission.storage.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     } else {
//       return true;
//     }
//     return false;
//   }
//
//   Future<void> prepareSaveDir() async {
//     final savedDir = Directory(localPath);
//     bool hasExisted = await savedDir.exists();
//     if (!hasExisted) {
//       await savedDir.create();
//     }
//   }
//
//   ReceivePort _port = ReceivePort();
//
//   void listenNow(String id1, int status1, int progress1) async {
//
//
//     progress = progress1 == -1 ? 0 : progress1;
//
//     print("show the progress $progress");
//     print("show migabytes $mbProgress");
//
//     calMbProgress();
//
//     if (status1 == DownloadTaskStatus.enqueued.index) {
//       emit(QueuedState());
//     } else if (status1 == DownloadTaskStatus.canceled.index) {
//       // dispose();
//       emit(CanceledState());
//     } else if (status1 == DownloadTaskStatus.failed.index) {
//       // dispose();
//       emit(FailedState());
//     } else if (status1 == DownloadTaskStatus.running.index) {
//       emit(RunningState());
//       // listenNow();
//     } else if (status1 == DownloadTaskStatus.complete.index &&
//         progress == 100) {
//       emit(CompleteState());
//     }
//   }
//
//   void requestDownload({bool showNot = true, Lesson? lessonModel}) async {
//     emit(RequestingState());
//
//     if (fileName2 != null) {
//       fileName = fileName2!;
//     }
//     if (!await checkPermission()) {
//       emit(InitialState());
//       return;
//     }
//     try {
//
//       await getContentLength();
//       getMbContentLength();
//       taskId = await FlutterDownloader.enqueue(
//         fileName: fileName,
//         url: link,
//         savedDir: localPath,
//         showNotification: true,
//         requiresStorageNotLow: false,
//         openFileFromNotification: false,
//       );
//
//       ///Store lessons in Sqlite table so users can view my downloaded lessons
//       if (lessonModel != null) {
//         SqliteHelper.insertLesson(
//             lessonModel, fileName2 ?? fileName, contentLength!);
//       }
//
//       dispose();
//       _port = ReceivePort();
//
//       IsolateNameServer.registerPortWithName(_port.sendPort, taskId);
//
//       _port.listen(
//         (message) {
//           listenNow(message[0], message[1], message[2]);
//         },
//       );
//
//       emit(QueuedState());
//     } catch (error) {
//       print("show the error $error");
//       emit(RequestingFailedState());
//     }
//   }
//
//   void retry() async {
//     emit(RetryingState());
//
//     await checkPermission();
//
//     try {
//       taskId = await FlutterDownloader.retry(
//           taskId: taskId, requiresStorageNotLow: false);
//
//       dispose();
//       _port = ReceivePort();
//       IsolateNameServer.registerPortWithName(_port.sendPort, taskId);
//
//       _port.listen(
//         (message) {
//           listenNow(message[0], message[1], message[2]);
//         },
//       );
//     } catch (error) {
//       emit(RetriedFailedState());
//     }
//     emit(RetriedState());
//   }
//
//   void cancelDownload() async {
//     emit(CancellingSate());
//     try {
//       // await FlutterDownloader.cancel(taskId: taskId);
//       await FlutterDownloader.cancel(
//         taskId: taskId,
//       );
//       dispose();
//     } catch (error) {
//       //
//     }
//     emit(CanceledState());
//   }
//
//   void removeTask() async {
//     emit(CancellingSate());
//     try {
//       // await FlutterDownloader.cancel(taskId: taskId);
//       await FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: true);
//     } catch (error) {
//       //
//     } finally {
//       dispose();
//
//       deleteFile();
//     }
//
//     emit(TaskNotFoundState());
//   }
//
//   void deleteFile() async {
//     if (!await checkPermission()) {
//       return;
//     }
//     await File(localPath + fileName).delete(recursive: true);
//   }
//
//   void deleteLesson(int lessonId) {
//     SqliteHelper.deleteLesson(lessonId);
//     removeTask();
//   }
//
//   void cancelLesson(int id) {
//     ///Remove lessons from Sqlite table
//     SqliteHelper.deleteLesson(id);
//
//     cancelDownload();
//   }
// }
