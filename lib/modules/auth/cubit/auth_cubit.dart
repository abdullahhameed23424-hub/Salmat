import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project_new/apis/exception_handler.dart';
import 'package:my_project_new/apis/network.dart';
import 'package:my_project_new/apis/urls.dart';
import 'package:my_project_new/helper/app_sharedPreferance.dart';
import 'dart:async';

import 'package:my_project_new/modules/auth/models/profile_response.dart';
import 'package:my_project_new/modules/auth/models/user.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> restPasswordFormKey = GlobalKey<FormState>();
  final FocusNode otpFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final otpController = TextEditingController();
  final emailController = TextEditingController();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isRemember = false;

  void updateRemember(bool? remember) {
    isRemember = remember!;
  }

  int selectedIndex = 0;

  void changeTap(int index) {
    selectedIndex = index;
    emit(ChangeTapState());
  }

///// log in

//// sign up

  bool isEmailVerified = false;

  GlobalKey<FormState> emailFormKey = GlobalKey();

  void changeVerifiedEmail() {
    emailController.text = "";
    otpController.text = "";
    isEmailVerified = false;
    codeSent = false; // only used in change profile screen
    emit(ChangeVerifiedEmailState());
  }

  void verifyEmail(Map? params) {
    isEmailVerified = params?['isVerified'] ?? false;
    otpController.text = params?['code'] ?? "";

    emit(VerifiedEmailSuccessState());
  }

  Future<void> createAccount() async {
    if (formKey.currentState!.validate() &&
        emailFormKey.currentState!.validate()) {
      emit(SignUpLoadingState());
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      try {
        Response response = await Network.postData(url: Urls.siginUp, data: {
          "username": userNameController.text.trim(),
          "phone_number": phoneController.text.trim(),
          "email": emailController.text.trim(),
          "code": otpController.text,
          "password": passwordController.text.trim(),
          'fcm_token': fcmToken,
        });
        emit(SignUpSuccessState());

        AppSharedPreferences.saveToken(response.data['data']['token']);
      } on DioException catch (e) {
        emit(SignUpErrorState(message: exceptionsHandle(error: e)));
      } catch (error) {
        emit(SignUpErrorState(message: unknownError()));
      }
    }
  }

  Future<void> getVerificationCode(
      {required String task, String? email}) async {
    emit(GetCodeLoadingState());

    try {
      await Network.postData(
          url: "${Urls.getVerificationCode}?type=$task",
          data: FormData.fromMap(
              {"email": email ?? emailController.text.trim()}));
      emit(GetCodeSuccessState());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        emit(GetCodeErrorState(message: error.response?.data['message']));
      } else {
        emit(GetCodeErrorState(message: "connection_error"));
      }
    }
  }

  Future<void> checkCode({required String email, required String task}) async {
    emit(CheckCodeLoadingState());
    String tempCode = otpController.text;
    try {
      Response response = await Network.postData(
          url: "${Urls.checkVerificationCode}?type=$task",
          data: {"email": email, "code": tempCode});

      emit(CheckCodeSuccessState(
          isValid: response.data['is_valid'], otpCode: tempCode));
    } on DioException catch (error) {
      emit(CheckCodeErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(CheckCodeErrorState(message: unknownError()));
    }
  }

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

  Future<void> restPassword() async {
    if (restPasswordFormKey.currentState!.validate()) {
      emit(ResetPasswordLoadingState());
      try {
        final Response response =
            await Network.postData(url: Urls.restPassword, data: {
          "email": emailController.text.trim(),
          "code": otpController.text,
          "password": passwordController.text.trim(),
          "password_confirmation": confirmPasswordController.text.trim()
        });

        emit(ResetPasswordSuccessState(message: response.data['message']));
      } on DioException catch (error) {
        emit(RestPasswordErrorState(message: exceptionsHandle(error: error)));
      } catch (error) {
        emit(RestPasswordErrorState(message: unknownError()));
      }
    }
  }

  late ProfileResponse profileResponse;
  late User user;

  Future<void> getProfile() async {
    emit(GetProfileLoadingState());
    try {
      final response = await Network.getData(url: Urls.profile);
      profileResponse = ProfileResponse.fromJson(response.data['data']);
      user = profileResponse.user;

      emit(GetProfileSuccessState());
    } on DioException catch (e) {
      emit(GetProfileErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      emit(GetProfileErrorState(message: unknownError()));
    }
  }

  // Future<void> editProfile() async {
  //   if (userNameController.text.trim() == profileResponse.user.username &&
  //       // emailController.text.trim() == profileResponse.user.email &&
  //       phoneController.text.trim() == profileResponse.user.phoneNumber &&
  //       fileUserImage == null) {
  //     emit(NoChangeState());
  //     return;
  //   }

  //   if (formKey.currentState!.validate()) {
  //     userName = userNameController.text.trim();
  //     // email = emailController.text.trim();

  //     phoneNumber = phoneController.text.trim();
  //     emit(EditProfileLoadingState());

  //     try {
  //       FormData formData = FormData.fromMap({
  //         "_method": "PUT",
  //         if (userName != profileResponse.user.username) "username": userName,
  //         // "email": email,

  //         if (phoneNumber != profileResponse.user.phoneNumber)
  //           "phone_number": phoneNumber,
  //         if (fileUserImage != null)
  //           "image": await MultipartFile.fromFile(fileUserImage!.path)
  //       });
  //       Response response =
  //           await Network.postData(url: Urls.profile, data: formData);

  //       profileResponse = ProfileResponse.fromJson(response.data);

  //       userName = profileResponse.user.username;
  //       email = profileResponse.user.email;
  //       phoneNumber = profileResponse.user.phoneNumber;

  //       if (profileResponse.user.image != null) {
  //         networkUserImage = profileResponse.user.image;
  //       }
  //       fillProfileFields();
  //       fileUserImage = null;
  //       emit(EditProfileSuccessState());
  //     } on DioException catch (e) {
  //       emit(EditProfileErrorState(message: exceptionsHandle(error: e)));
  //     } catch (error) {
  //       emit(EditProfileErrorState(message: unknownError()));
  //     }
  //   }
  // }

  File? fileUserImage;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      fileUserImage = File(pickedFile.path);
      emit(AddImageState());
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

  bool codeSent = false;
  FocusNode emailFocusNode = FocusNode();

  Future<void> updateEmail() async {
    emit(UpdateEmailLoadingState());
    try {
      await Network.postData(url: Urls.updateEmail, data: {
        "_method": "PUT",
        "email": emailController.text.trim(),
        "code": otpController.text
      });

      emit(UpdateEmailSuccessState(email: emailController.text.trim()));
    } on DioException catch (e) {
      emit(UpdateEmailErrorState(message: exceptionsHandle(error: e)));
    } catch (error) {
      emit(UpdateEmailErrorState(message: unknownError()));
    }
  }

  final PageController createAccountInfoController = PageController();
  int currentInfoIndex = 0;

  void onChangeAddUserInfo(int index) {
    currentInfoIndex = index;
    emit(LoginSuccessState()); // well  remove this line after integration
  }
}
