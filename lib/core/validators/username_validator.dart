import 'package:my_project_new/helper/app_sharedPreferance.dart';

const Map<String, Map<String, String>> messages = {
  "ar": {
    "field_required": "اسم المستخدم لا يمكن أن يكون فارغًا.",
    "username_min_length": "اسم المستخدم يجب أن يكون 3 أحرف على الأقل.",
    "username_max_length": "اسم المستخدم لا يمكن أن يزيد عن 20 حرفًا."
  },
  "en": {
    "field_required": "Username cannot be empty.",
    "username_min_length": "Username must be at least 3 characters long.",
    "username_max_length": "Username cannot be more than 20 characters long."
  }
};

class UsernameValidator {
  static String? validate(String? value) {
    String locale = AppSharedPreferences.getLocale; // Fetch the user's locale
    value = value?.trim();

    if (value == null || value.isEmpty) {
      return messages[locale]!['field_required'];
    } else if (value.length < 3) {
      return messages[locale]!['username_min_length'];
    } else if (value.length > 20) {
      return messages[locale]!['username_max_length'];
    }
    return null;
  }
}
