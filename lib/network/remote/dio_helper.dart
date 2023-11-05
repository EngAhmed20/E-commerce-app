
import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {},
      ),

    );
  }
 static Future<Response> getData({required String url, Map<String,dynamic>?query,
 String lang='en',String?token})async
  {
    dio!.options.headers= {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',

    };

    return await dio!.get(url,queryParameters: query,);
  }
  static Future<Response>postData
      ({required String url,Map<String,dynamic>?query,required Map<String,dynamic>data,
    String lang='en',String?token})async
{
  dio!.options.headers= {
'lang':lang,
'Authorization':token,
'Content-Type':'application/json',

  };
  return dio!.post(url,queryParameters: query,data: data);
}
  static Future<Response>PutData
      ({required String url,Map<String,dynamic>?query,required Map<String,dynamic>data,
    String lang='en',String?token})async
  {
    dio!.options.headers= {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',

    };
    return dio!.put(url,queryParameters: query,data: data);
  }
  static Future<Response>deleteData
      ({required String url,Map<String,dynamic>?query, Map<String,dynamic>?data,
    String lang='en',String?token})async
  {
    dio!.options.headers= {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',

    };
    return dio!.delete(url);
  }
}


