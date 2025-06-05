import 'package:my_project_new/helper/app_sharedPreferance.dart';

const Map<String, Map<String, String>> messages = {
  "ar": {
    "field_required": "هذا الحقل مطلوب.",
    "phone_min_length": "رقم الهاتف يجب أن يكون 10 أرقام."
  },
  "en": {
    "field_required": "This field is required.",
    "phone_min_length": "Phone number must be 10 digits."
  }
};

class PhoneNumberValidator {
  static String? validate(String? phoneNumber) {
    String locale = AppSharedPreferences.getLocale; // Fetch the user's locale

    if (phoneNumber == null || phoneNumber.isEmpty) {
      return messages[locale]!['field_required'];
    }
    if (phoneNumber.length < 10) {
      return messages[locale]!['phone_min_length'];
    }
    return null;
  }
}
