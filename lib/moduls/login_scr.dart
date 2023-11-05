import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/login_cubit/log_cubit.dart';
import 'package:shop_app/Cubit/login_cubit/states.dart';
import 'package:shop_app/moduls/register_Scr.dart';
import 'package:shop_app/network/local/shared_pref/cache_helper.dart';
import 'package:shop_app/shared/component/Custom_text_filed.dart';
import 'package:shop_app/shared/component/constant.dart';

import '../layout/shop_app.dart';


class LoginScr extends StatelessWidget {
  var formkey= GlobalKey<FormState>();
 var emailcontroller= TextEditingController();
 var passcontroller= TextEditingController();


 @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShopLoginCubit(),
    child: BlocConsumer<ShopLoginCubit,LoginState>(
      listener: (context,state){
        if(state is LoginSucessState)
          {
            if(state.loginModel.status!)
              {

                print(state.loginModel.message);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token!)
                .then((value){
                  token=state.loginModel.data!.token;
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ShopLayout()), (route) => false);
                  emailcontroller.clear();
                  passcontroller.clear();
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
                print(state.loginModel.message);




              }
          }
      },
      builder: (context,state){
        var cubit =ShopLoginCubit.get(context);
       return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
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
                      defaulttextform(controller: emailcontroller, type: TextInputType.emailAddress,
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
                      defaulttextform(controller: passcontroller, type: TextInputType.visiblePassword,
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
                        suficon: cubit.suffix,
                        sufixpress: (){
                        cubit.changePassVisiblity();
                        },),
                      SizedBox(height: 20,),
                      ConditionalBuilder(condition: state is!LoginLoadingState,
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
                                    cubit.userLogin(email: emailcontroller.text, pass: passcontroller.text);
                                  }
                              },child:Text('Login') ,
                            ),
                          ),

                          fallback: (context)=>Center(child: CircularProgressIndicator())),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text('don\'t have an account ?'),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScr()),);

                          }, child: Text('register now'))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
