import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

String? token = '';
int cartLength = 0;
void navigateTo(BuildContext context,Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void showToast(msg,Color color){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );}
Widget myDivider() => Container(
  color: Colors.grey[300],
  height: 1,
  width: double.infinity,
);
String getDateTomorrow ()
{
 DateTime dateTime=DateTime.now().add(Duration(days: 2));
 String date= DateFormat.yMMMd().format(dateTime);
 return date;
}