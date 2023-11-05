

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/register_cubit/register_state.dart';
import 'package:shop_app/model/login_model.dart';

import '../../network/end_points.dart';
import '../../network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<RegisterState>{
  ShopRegisterCubit():super(RegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? registermodel;
  void userRegister({required String email,required String pass,required String name,required String phone})
  {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email':email,
      'password':pass,
      'name':name,
      'phone':phone,
    }).then((value) {
      registermodel=ShopLoginModel.fromJson(value.data);
      emit(RegisterSucessState(registermodel!));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
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