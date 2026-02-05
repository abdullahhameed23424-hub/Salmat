import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'file_manager_state.dart';

class FileManagerCubit extends Cubit<FileManagerState> {
  FileManagerCubit() : super(FileManagerFileInitialState());
  static late String downloadsPath;
  static late String  privatePath;
  static late String temporary;
  static init() async {

    privatePath = '${(await getApplicationSupportDirectory()).path}/';
    temporary = (await getTemporaryDirectory()).path;
    if (Platform.isAndroid) {
      (await DeviceInfoPlugin().androidInfo).id;
      try {
        downloadsPath = '${(await getDownloadsDirectory())!.path}/';

      } catch (e) {
        final directory = await getExternalStorageDirectory();
        downloadsPath = directory!.path;
      }
    } else if (Platform.isIOS) {
      downloadsPath = '${(await getDownloadsDirectory())!.absolute.path}/';
    }
  }

  void deleteFile(String path) async {
    await File(path).delete(recursive: true);
    emit(FileManagerFileDeletedState());
  }

  void emitFileManagerFileExistState() {
    emit(FileManagerFileExistState());
  }

  void renameFile(String path, String newPath) async {
    await File(path).rename(newPath);
    emit(FileManagerFileRenameSuccessfulState());
  }
  
}
