part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// sign up 

final class ChangeTapState extends AuthState {}

final class ChangeVerifiedEmailState extends AuthState {}

final class VerifiedEmailSuccessState extends AuthState {}

final class GetCodeLoadingState extends AuthState {}

final class GetCodeSuccessState extends AuthState {}

final class GetCodeErrorState extends AuthState {
  GetCodeErrorState({required this.message});
  final String message;
}

///

final class SignUpLoadingState extends AuthState {}

final class SignUpErrorState extends AuthState {
  SignUpErrorState({required this.message});
  final String message;
}

final class SignUpSuccessState extends AuthState {}
//

final class CheckCodeLoadingState extends AuthState {}

final class CheckCodeSuccessState extends AuthState {
  CheckCodeSuccessState({
    required this.isValid,
    required this.otpCode,
  });
  final bool isValid;
  final String otpCode;
}

final class CheckCodeErrorState extends AuthState {
  CheckCodeErrorState({required this.message});
  final String message;
}
//

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {
  LoginErrorState({required this.message});
  final String message;
}

///////
 
final class LogoutLoadingState extends AuthState {}

final class LogoutSuccessState extends AuthState {}

final class LogoutErrorState extends AuthState {
  LogoutErrorState({required this.message, this.code = 0});
  final String message;
  final int code;
}

//////
final class ResetPasswordLoadingState extends AuthState {}

final class ResetPasswordSuccessState extends AuthState {
  ResetPasswordSuccessState({required this.message});
  final String message;
}

final class RestPasswordErrorState extends AuthState {
  RestPasswordErrorState({required this.message});
  final String message;
}

final class GetProfileLoadingState extends AuthState {}

final class GetProfileSuccessState extends AuthState {}

final class GetProfileErrorState extends AuthState {
  GetProfileErrorState({required this.message});
  final String message;
}

final class UnAuthenticatedState extends AuthState {}

final class EditProfileLoadingState extends AuthState {}

final class EditProfileSuccessState extends AuthState {}

final class EditProfileErrorState extends AuthState {
  EditProfileErrorState({required this.message});
  final String message;
}

//
final class NoChangeState extends AuthState {}

final class AddImageState extends AuthState {}

///

final class ChangePasswordLoadingState extends AuthState {}

final class ChangePasswordSuccessState extends AuthState {}

final class ChangePasswordErrorState extends AuthState {
  ChangePasswordErrorState({required this.message});
  final String message;
}

//
 