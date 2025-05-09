import 'package:my_project_new/helper/cach_helper.dart';

class AppSharedPreferences {
  //token
  static String token = 'token';
  static String get getToken => CacheHelper.getData(key: token) ?? "no token";
  static saveToken(String value) =>
      CacheHelper.saveData(key: token, value: value);
  static bool get hasToken => CacheHelper.contains(token);
  static void get removeToken => CacheHelper.removeData(key: token);

  // ignore: constant_identifier_names
  static const String LOCALE = 'locale';
  static String get getLocale => CacheHelper.getData(key: LOCALE) ?? "ar";
  static saveLocale(String value) =>
      CacheHelper.saveData(key: LOCALE, value: value);
  static bool get haslocale => CacheHelper.contains(LOCALE);
  static void get removelocale => CacheHelper.removeData(key: LOCALE);



    static void saveQuality(int value) =>
      CacheHelper.saveData(key: "quality", value: value);

  static int get getQuality =>
      CacheHelper.getData(
        key: "quality",
      ) ??
      -1;

  static void removeQuality() => CacheHelper.removeData(key: "quality");

}
