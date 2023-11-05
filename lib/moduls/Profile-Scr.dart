import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/moduls/ChangePassScreen.dart';
import 'package:shop_app/shared/component/constant.dart';
import '../shared/component/Custom_text_filed.dart';
import '../shared/component/Sing_Out.dart';
class ProfileScr extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(listener: (context,state){

    },
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        var model=ShopCubit.get(context).userModel;
        nameController.text=model!.data!.name!;
        emailController.text=model!.data!.email!;
        phoneController.text=model!.data!.phone!;
        return ConditionalBuilder(condition: cubit.userModel!=null,
          builder:(context)=> Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(state is ShopUpdateUserLoadingDataState)
                      LinearProgressIndicator(),
                    defaulttextform(controller: nameController, type: TextInputType.name,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return'please enter your name';
                        }
                      },
                      label: 'Name',
                      preficon:Icons.person,
                      ontap: (){
                      cubit.UpdateUserInfo(true);
                      }
                    ),
                    SizedBox(height: 20,),
                    defaulttextform(controller: emailController, type: TextInputType.emailAddress,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return'please enter your email';
                        }
                      },
                      label: 'Email',
                      preficon:Icons.email,
                        ontap: (){
                          cubit.UpdateUserInfo(true);
                        }
                    ),
                    SizedBox(height: 20,),
                    defaulttextform(controller: phoneController, type: TextInputType.phone,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return'please enter your phone';
                        }
                      },
                      label: 'phone',
                      preficon:Icons.phone,
                        ontap: (){
                          cubit.UpdateUserInfo(true);
                        }
                    ),
                    if(cubit.change==true)
                      Column(
                       children: [
                         SizedBox(height: 10,),
                         Container(
                           height: 50,
                           width: double.infinity,

                           child: MaterialButton(
                             onPressed: (){
                               if(formkey.currentState!.validate())
                               {
                                 cubit.UpdateUserData(
                                   name: nameController.text,
                                   email: emailController.text,
                                   phone: phoneController.text,
                                 );
                               }
                               cubit.change=false;
                             },child:Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.update,color: Colors.blue,),
                               SizedBox(width: 5,),
                               Text('Update',style: TextStyle(color: Colors.blue),),
                             ],) ,
                           ),
                         ),
                       ],
                      ),

                    InkWell(
                      onTap: (){
                        navigateTo(context, ChangePassScr());
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 10),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                          [
                            Icon(Icons.password),
                            SizedBox(width: 10,),
                            Text('Change Password',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),




                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),);
      },
    );
  }
}