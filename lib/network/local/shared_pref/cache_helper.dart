

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;
  static init()async
  {
    sharedPreferences =await SharedPreferences.getInstance();
  }
  static dynamic getData({
  required String key,
})
  {
    return sharedPreferences!.get(key);
  }
static Future<bool> saveData(
  {
  required String key,
    required dynamic value,
})async{
    if(value is String){
      return await sharedPreferences!.setString(key, value);
    }
    if(value is int){
      return await sharedPreferences!.setInt(key, value);
    }
    if(value is bool){
      return await sharedPreferences!.setBool(key, value);
    }
    return await sharedPreferences!.setDouble(key, value);
    
 }

  static  Future<bool> SignOut({
  required String key,
})async
 {
   return  sharedPreferences!.remove(key);
 }
}


/*save stating after close app
*to skip bord one time
* قد يتم الاحتفاظ بالبيانات على القرص بشكل غير متزامن ،
* وليس هناك ما يضمن استمرار عمليات الكتابة على القرص بعد العودة ،
*  لذلك يجب عدم استخدام هذا المكون الإضافي لتخزين البيانات الهامة.
*
* */