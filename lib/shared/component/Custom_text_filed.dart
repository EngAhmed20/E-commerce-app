import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaulttextform({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  VoidCallback? ontap,
  required String? Function(String?)? validator,
  String? label='',
  String? hint='',
   IconData? preficon,
  VoidCallback? sufixpress,
  bool ispass=false,
  IconData? suficon,
  bool isCleckable=true,

})=>TextFormField(
  controller: controller,
  keyboardType:type,
  enabled: isCleckable,
  obscureText: ispass,
  onChanged: onChange,
  onTap: ontap,
  onFieldSubmitted: onSubmit,
  decoration:InputDecoration(
    label:Text(label!),
    hintText: '$hint',
    hintStyle:TextStyle(color: Colors.grey,fontSize: 17),
    border:OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
    prefixIcon:Icon(preficon),
    suffixIcon: IconButton(
        onPressed: sufixpress,
        icon: Icon(suficon)),

  ),
  validator: validator,
);