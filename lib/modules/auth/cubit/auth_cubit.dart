import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salamat/apis/exception_handler.dart';
import 'package:salamat/apis/network.dart';
import 'package:salamat/apis/urls.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:salamat/modules/auth/models/profile_response.dart';
import 'package:salamat/modules/auth/models/user.dart';
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
      String? udid;
      try {
        udid = await FlutterUdid.udid;
      } catch (error) {
        //
      }

      String? fcmToken;
      try {
        fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (error) {
        //
      }
      try {
        Response response = await Network.postData(url: Urls.login, data: {
          "username": userNameController.text.trim(),
          "password": passwordController.text.trim(),
          'fcm_token': fcmToken,
          if (udid != null) 'fingerprint': udid
        });

        await AppSharedPreferences.saveToken(
            response.data['data']['user']['token']);
        await AppSharedPreferences.saveUserID(
            response.data['data']['user']['id'].toString());
        AppSharedPreferences.removeGust;
        await Network.init();
        if (isClosed) return;
        emit(LoginSuccessState());
      } on DioException catch (error) {
        if (isClosed) return;
        emit(LoginErrorState(message: exceptionsHandle(error: error)));
      } catch (error) {
        if (isClosed) return;
        emit(LoginErrorState(message: unknownError()));
      }
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    try {
      await Network.postData(url: Urls.logout);
      if (isClosed) return;
      emit(LogoutSuccessState());

      AppSharedPreferences.removeToken;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        AppSharedPreferences.removeToken;
        if (isClosed) return;
        emit(LogoutErrorState(
            message: error.response?.data['message'], code: 401));
      } else {
        if (isClosed) return;
        emit(LogoutErrorState(message: exceptionsHandle(error: error)));
      }
    } catch (error) {
      if (isClosed) return;
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
      if (isClosed) return;
      emit(GetProfileSuccessState());
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        if (isClosed) return;
        emit(UnAuthenticatedState());
        return;
      }
      if (isClosed) return;
      emit(GetProfileErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      if (isClosed) return;
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
        if (isClosed) return;
        emit(ChangePasswordSuccessState());
      } on DioException catch (e) {
        if (isClosed) return;
        emit(ChangePasswordErrorState(message: exceptionsHandle(error: e)));
      } catch (error) {
        if (isClosed) return;
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
      if (isClosed) return;
      emit(EditProfileSuccessState());
    } on DioException catch (error) {
      if (isClosed) return;
      emit(EditProfileErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      if (isClosed) return;
      emit(EditProfileErrorState(message: unknownError()));
    }
  }

  Future<void> deleteImage() async {
    emit(DeleteImageLoadingState());
    try {
      final FormData formData =
          FormData.fromMap({"_method": "PUT", "image": null});

      await Network.postData(url: "${Urls.profile}/update", data: formData);
      if (isClosed) return;
      emit(DeleteImageSuccessState());
    } on DioException catch (error) {
      if (isClosed) return;
      emit(DeleteImageErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      if (isClosed) return;
      emit(DeleteImageErrorState(message: unknownError()));
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
    try {
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
    } catch (e) {
      return file;
    }

    return file;
  }
}
