import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/bloc_observe.dart';
import 'package:shop_app/network/local/shared_pref/cache_helper.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/component/paymnt/stripe_keys.dart';
import 'package:shop_app/shared/thems.dart';
import 'layout/shop_app.dart';
import 'moduls/login_scr.dart';
import 'moduls/on_boarding.dart';
import 'network/remote/dio_helper.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();
 Stripe.publishableKey=ApiKeys.publishableKey;
   Widget widget;
 bool? onBoarding =CacheHelper.getData(key: 'Showboard');
  token =CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding ==false)
    {
      if(token!=null) widget=ShopLayout();
      else widget=LoginScr();
    }
  else
    {
      widget=OnBoardingScr();
    }

  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

   MyApp({required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>ShopCubit()..getHomeData()..GetCategories()
      ..GetFavorites()..GetUserData()..getCartData()..getAddresses(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode(),

      home: startWidget,
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}


