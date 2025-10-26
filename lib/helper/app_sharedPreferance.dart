import 'package:salamat/helper/cach_helper.dart';
import 'package:video_player/video_player.dart';

class AppSharedPreferences {
  //token
  static String token = 'token';
  static String get getToken => CacheHelper.getData(key: token) ?? "no token";
  static saveToken(String value) =>
      CacheHelper.saveData(key: token, value: value);
  static bool get hasToken => CacheHelper.contains(token);
  static void get removeToken => CacheHelper.removeData(key: token);

  static String userID = 'userID';
  static String get getUserID =>
      CacheHelper.getData(key: userID) ?? "no userID";
  static saveUserID(String value) =>
      CacheHelper.saveData(key: userID, value: value);
  static bool get hasUserID => CacheHelper.contains(userID);
  static void get removeUserID => CacheHelper.removeData(key: userID);

  // ignore: constant_identifier_names
  static const String LOCALE = 'locale';
  static String get getLocale => CacheHelper.getData(key: LOCALE) ?? "ar";
  static saveLocale(String value) =>
      CacheHelper.saveData(key: LOCALE, value: value);
  static bool get haslocale => CacheHelper.contains(LOCALE);
  static void get removelocale => CacheHelper.removeData(key: LOCALE);

  // ignore: constant_identifier_names
  static const String GUEST = 'GUEST';
  static String get getIsGuest => CacheHelper.getData(key: GUEST) ?? "ar";
  

  static saveGuest(String value) =>
      CacheHelper.saveData(key: GUEST, value: value);



  static bool get isGuest => CacheHelper.contains(GUEST);
  static void get removeGust => CacheHelper.removeData(key: GUEST);

  static void saveQuality(int value) =>
      CacheHelper.saveData(key: "quality", value: value);

  static int get getQuality =>
      CacheHelper.getIntData(
        key: "quality",
      );

  static void removeQuality() => CacheHelper.removeData(key: "quality");


  static String get viewType => CacheHelper.getData(key: 'view_type') ?? 'textureView';
  static saveViewType(String value) =>
      CacheHelper.saveData(key: 'view_type', value: value);



}
