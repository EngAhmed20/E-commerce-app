
import 'package:flutter/material.dart';
import '../../moduls/login_scr.dart';
import '../../network/local/shared_pref/cache_helper.dart';

void SignOut(context){
 CacheHelper.SignOut(key: 'token').then((value){
 if(value)
 {
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScr()), (route) => false);

 }
 });
 }