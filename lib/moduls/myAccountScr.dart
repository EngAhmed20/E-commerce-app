import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/moduls/AddressScreen.dart';
import 'package:shop_app/moduls/FAQs_Scr.dart';
import 'package:shop_app/moduls/Profile-Scr.dart';
import 'package:shop_app/moduls/contact_Screen.dart';
import 'package:shop_app/shared/component/constant.dart';

import '../shared/component/Sing_Out.dart';
class MyAccountScr extends StatelessWidget {
var formkey=GlobalKey<FormState>();


 @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(listener: (context,state){
      if(state is ShopGetUserDataSucessState)
        {


        }
    },
    builder: (context,state){
      var cubit=ShopCubit.get(context);
      var model=ShopCubit.get(context).userModel;
      return ConditionalBuilder(condition: cubit.userModel!=null,
          builder:(context)=> SingleChildScrollView(
            physics:BouncingScrollPhysics(),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: Column(
                        children: [
                          RichText(text: TextSpan(
                            children:[
                              TextSpan(text: 'Ahlan ',style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold)),
                              TextSpan(text: '${model!.data!.name!.split(' ').elementAt(0)}',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold))
                            ]
                          )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      navigateTo(context, ProfileScr());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children:
                        [
                          Icon(Icons.person_outline,color: Colors.green,),
                          SizedBox(width: 10,),
                          Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      cubit.getAddresses();
                      navigateTo(context, AddressScr());

                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children:
                        [
                          Icon(Icons.map_outlined,color: Colors.green,),
                          SizedBox(width: 15,),
                          Text('Location',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          Spacer(),
                          Text('Egypt'),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      ShopCubit.get(context).getFAQsData();
                      navigateTo(context, FAQsScreen());
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children:
                        [
                          Icon(Icons.info_outline_rounded,color: Colors.green,),
                          SizedBox(width: 15,),
                          Text('FAQs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      ShopCubit.get(context).getContactData();
                      navigateTo(context, ContactScr());
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children:
                        [
                          Icon(Icons.message,color: Colors.green,),
                          SizedBox(width: 15,),
                          Text('Contact Us',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),


                  /*InkWell(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.mail,color: Colors.blue,),
                          SizedBox(width: 15,),
                          Text('Contact Us',style: TextStyle(),),
                        ],
                      ),
                    )
                  ),*/
                  SizedBox(height: 15,),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    height: 60,
                    child: InkWell(
                      onTap: (){
                        SignOut(context);                    },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Icon(Icons.power_settings_new),
                          SizedBox(width: 10,),
                          Text('SignOut',style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                  ),





                ],
              ),
            ),

          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),);
    },
    );
  }
}