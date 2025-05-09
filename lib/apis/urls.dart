// ignore_for_file: constant_identifier_names

class Urls {
  static const String domain = "https://slamat-back.icrcompany.net";
  // static const String domain = "https://m-back.muahep.com.sy";
  static const String storageUrl = "$domain/storage/";
  static const String baseUrl = "$domain/api/v1/";
  static const String login = "login";
  static const String CHANGE_PASSWORD = "change-password";

  static const String siginUp = "register";
  static const String checkVerificationCode = "check/verification";
  static const String restPassword = "reset-password";
  static const String getVerificationCode = "send/verification-code";
  static const String logout = "logout";
  static const String profile = "profile";
  static const String home = "home";
  static const String sections = "sections";
  static const String subjects = "subjects";

  static String notifications({required int read, required int page}) =>
      'notifications?paginate=1&page=$page&mark_read=$read';

  static const String contactMessages = "contact-messages";

  static const String librarySections = "sections?type=book_section";

  static const String offers = "offers";

  static const updateEmail = '${baseUrl}update-email';

  static const appInfo = 'infos';
}
