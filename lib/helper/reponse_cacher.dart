
import 'dart:convert';

import 'cach_helper.dart';

class ResponseCacher{

  static Future<void> cache(String key, dynamic value)async{
    await CacheHelper.saveData(key: key,value: jsonEncode(value));
  }
  static bool hasCache(String key){
    return CacheHelper.contains(key);
  }

  static Map<String,dynamic> getCache(String key){

    return jsonDecode(CacheHelper.getData(key: key));
  }

  static Future<void> removeCache(String key)async{
    if(CacheHelper.contains(key)) {
      await CacheHelper.removeData(key: key);
    }
  }

}