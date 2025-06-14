import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/helper/app_sharedPreferance.dart';
import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:my_project_new/modules/auth/models/profile_response.dart';
import 'package:my_project_new/modules/auth/models/user.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> restPasswordFormKey = GlobalKey<FormState>();

  final FocusNode passwordFocusNode = FocusNode();

  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      // String? fcmToken = await FirebaseMessaging.instance.getToken();

      emit(LoginLoadingState());
      try {
        Response response = await Network.postData(url: Urls.login, data: {
          "username": userNameController.text.trim(),
          "password": passwordController.text.trim(),
          'fcm_token': "fcmToken",
        });

        await AppSharedPreferences.saveToken(
            response.data['data']['user']['token']);
        await AppSharedPreferences.saveUserID(
            response.data['data']['user']['id'].toString());
        await Network.init();

        emit(LoginSuccessState());
      } on DioException catch (error) {
        emit(LoginErrorState(message: exceptionsHandle(error: error)));
      } catch (error) {
        emit(LoginErrorState(message: unknownError()));
      }
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    try {
      await Network.postData(
        url: Urls.logout,
      );

      emit(LogoutSuccessState());

      AppSharedPreferences.removeToken;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        AppSharedPreferences.removeToken;
        emit(LogoutErrorState(
            message: error.response?.data['message'], code: 401));
      } else {
        emit(LogoutErrorState(message: exceptionsHandle(error: error)));
      }
    } catch (error) {
      emit(LogoutErrorState(message: unknownError()));
    }
  }

  late ProfileResponse profileResponse;
  late User user;
  int notificationCount = 0;
  Future<void> getProfile() async {
    emit(GetProfileLoadingState());
    try {
      final response = await Network.getData(url: Urls.profile);
      profileResponse = ProfileResponse.fromJson(response.data['data']);
      user = profileResponse.user;
      notificationCount = response.data['notifications_count'];
      emit(GetProfileSuccessState());
    } on DioException catch (e) {
      emit(GetProfileErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      emit(GetProfileErrorState(message: unknownError()));
    }
  }

  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      emit(ChangePasswordLoadingState());
      FormData formData = FormData.fromMap({
        "_method": "PUT",
        "old_password": oldPasswordController.text,
        "password": newPasswordController.text,
        "password_confirmation": confirmNewPasswordController.text,
      });
      try {
        await Network.postData(url: Urls.CHANGE_PASSWORD, data: formData);
        emit(ChangePasswordSuccessState());
      } on DioException catch (e) {
        emit(ChangePasswordErrorState(message: exceptionsHandle(error: e)));
      } catch (error) {
        emit(ChangePasswordErrorState(message: unknownError()));
      }
    }
  }

  Future<void> editImage() async {
    emit(EditProfileLoadingState());

    try {
      final FormData formData = FormData.fromMap({
        "_method": "PUT",
        "image": await MultipartFile.fromFile(userImageFile!.path)
      });

      await Network.postData(url: "${Urls.profile}/update", data: formData);
      userImageFile = null;
      emit(EditProfileSuccessState());
    } on DioException catch (error) {
      emit(EditProfileErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(EditProfileErrorState(message: unknownError()));
    }
  }

  File? userImageFile;
  Future<void> pickImage({required ImageSource imageSource}) async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      userImageFile = await compressImage(File(pickedFile.path));

      editImage();
    }
  }

  Future<File?> compressImage(File file) async {
    int originalSize = file.lengthSync();
    print(
        "Original image size: ${(originalSize / 1024 / 1024).toStringAsFixed(2)} MB");

    final dir = await getTemporaryDirectory();
    final targetPath =
        path.join(dir.path, 'compressed_${path.basename(file.path)}');

    XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 80,
      minWidth: 1024,
      minHeight: 1024,
    );

    if (result != null) {
      File compressedFile = File(result.path);

      int compressedSize = compressedFile.lengthSync();
      print(
          "Compressed image size: ${(compressedSize / 1024 / 1024).toStringAsFixed(2)} MB");

      return compressedFile;
    }

    return null;
  }
}
