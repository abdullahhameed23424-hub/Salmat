import 'package:salamat/helper/app_sharedPreferance.dart';

const Map<String, Map<String, String>> messages = {
  "ar": {
    "field_required": "هذا الحقل مطلوب.",
    "invalid_email": "الرجاء إدخال بريد إلكتروني صالح.",
    "email_must_be_verified": "يجب التحقق من البريد الإلكتروني."
  },
  "en": {
    "field_required": "This field is required.",
    "invalid_email": "Please enter a valid email.",
    "email_must_be_verified": "Email must be verified."
  }
};

class EmailValidator {
  static String? validate(String? email) {
    String locale = AppSharedPreferences.getLocale; // Fetch the user's locale
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (email == null || email.isEmpty) {
      return messages[locale]?['field_required'];
    }
    if (!emailRegex.hasMatch(email)) {
      return messages[locale]?['invalid_email'];
    }
    return null;
  }
}
