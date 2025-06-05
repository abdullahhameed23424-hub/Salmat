import 'package:my_project_new/helper/app_sharedPreferance.dart';

const Map<String, Map<String, String>> messages = {
  "ar": {
    "field_required": "هذا الحقل مطلوب.",
    "password_min_length": "كلمة المرور يجب أن تكون 8 محارف على الأقل."
  },
  "en": {
    "field_required": "This field is required.",
    "password_min_length": "Password must be at least 8 characters long."
  }
};

class PasswordValidator {
  static String? validate(String? password) {
    String locale = AppSharedPreferences.getLocale; // Fetch the user's locale

    if (password == null || password.isEmpty) {
      return messages[locale]!['field_required'];
    }
    if (password.length < 8) {
      return messages[locale]!['password_min_length'];
    }
    return null;
  }
}
