import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/login_cubit/states.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

import '../../model/login_model.dart';

class ShopLoginCubit extends Cubit<LoginState>{
 ShopLoginCubit():super(LoginInitialState());
 static ShopLoginCubit get(context)=>BlocProvider.of(context);
 ShopLoginModel? loginmodel;
 void userLogin({required String email,required String pass})
 {
  emit(LoginLoadingState());
  DioHelper.postData(url: LOGIN, data: {
   'email':email,
   'password':pass,
  }).then((value) {
   loginmodel=ShopLoginModel.fromJson(value.data);
   emit(LoginSucessState(loginmodel!));
  }).catchError((error){
   emit(LoginErrorState(error.toString()));
  });
 }
 IconData suffix= Icons.visibility_outlined;
 bool isPass=true;
 void changePassVisiblity()
 {
  isPass=!isPass;
  suffix=isPass ?Icons.visibility_outlined :Icons.visibility_off_outlined;
  emit(ChangePassVisiblityState());
 }
}