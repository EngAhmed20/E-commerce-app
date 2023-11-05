import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/shared/component/paymnt/stripe_keys.dart';

abstract class paymentManager{
 static Future<void>makePayment(int amount,String currency)async {
    try{
      String clientSecret=await _getClientSecret((amount*100).toString(),currency);
      await _initPaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    }catch(error){
      throw Exception(error.toString());
    }

  }
  static Future<void>_initPaymentSheet(String clientSecret)async{
  await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
     paymentIntentClientSecret:clientSecret,
     merchantDisplayName: 'Fast Shop',
   ));
  }
 static Future<String> _getClientSecret(String amount,String currency)async{
    Dio pay=Dio();
   var response= await pay.post(
     'https://api.stripe.com/v1/payment_intents',
     options: Options(
       headers: {
         'Authorization': 'Bearer ${ApiKeys.secretKey}',
         'Content-Type': 'application/x-www-form-urlencoded'
       },
     ),
     data: {
       'amount': amount,
       'currency': currency,
     },
    );
   return response.data["client_secret"];
  }
}