import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/Cubit/register_cubit/register_state.dart';

import '../Cubit/Shop_Cubit/Shop_Cubit.dart';
import '../layout/shop_app.dart';
import '../network/local/shared_pref/cache_helper.dart';
import '../shared/component/Custom_text_filed.dart';
import '../shared/component/constant.dart';

class RegisterScr extends StatelessWidget {
  var formkey= GlobalKey<FormState>();
  var emailController= TextEditingController();
  var passController= TextEditingController();
  var nameController= TextEditingController();
  var phoneController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,RegisterState>(
        listener: (context,state){
          if(state is RegisterSucessState)
          {
            if(state.registermodel.status!)
            {

              print(state.registermodel.message);
              CacheHelper.saveData(key: 'token', value: state.registermodel.data!.token!)
                  .then((value){
                token=state.registermodel.data!.token;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ShopLayout()), (route) => false);
                emailController.clear();
                passController.clear();
                nameController.clear();
                phoneController.clear();
                ShopCubit.get(context).CurrentIndex=0;
                ShopCubit.get(context).getHomeData();
                ShopCubit.get(context).GetCategories();
                ShopCubit.get(context).GetUserData();
                ShopCubit.get(context).getCartData();
                ShopCubit.get(context).getAddresses();


              });


            }
            else
            {
              print(state.registermodel.message);




            }
          }
        },
        builder: (context,state){
          var cubit= ShopRegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style:Theme.of(context).textTheme.headline6,),
                        Text('login noe to browse our hot offers',style:Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey
                        )),
                        SizedBox(height: 30,),
                        defaulttextform(controller: nameController, type: TextInputType.name,
                            validator: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return'please enter your name';
                              }
                            },
                            label: 'name',
                            preficon: Icons.person),
                        SizedBox(height: 30,),  defaulttextform(controller: phoneController, type: TextInputType.emailAddress,
                            validator: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return'please enter your phone';
                              }
                            },
                            label: 'phone',
                            preficon: Icons.phone),
                        SizedBox(height: 30,),
                        defaulttextform(controller: emailController, type: TextInputType.emailAddress,
                            validator: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return'please enter your email';
                              }
                            },
                            label: 'email address',
                            preficon: Icons.email),
                        SizedBox(height: 30,),
                        defaulttextform(controller: passController, type: TextInputType.visiblePassword,
                          ispass: cubit.isPass,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return'please enter your password';
                            }
                          },
                          label: 'password',
                          preficon: Icons.lock_outline,
                          suficon:cubit.suffix,
                          sufixpress: (){
                             cubit.changePassVisiblity();
                          },),
                        SizedBox(height: 20,),
                        ConditionalBuilder(condition: state is!RegisterLoadingState,
                            builder:(context)=> Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  if(formkey.currentState!.validate())
                                  {
                                     cubit.userRegister(email: emailController.text,
                                         pass: passController.text,
                                         name: nameController.text,
                                         phone: phoneController.text);
                                  }
                                },child:Text('Register') ,
                              ),
                            ),

                            fallback: (context)=>Center(child: CircularProgressIndicator())),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
