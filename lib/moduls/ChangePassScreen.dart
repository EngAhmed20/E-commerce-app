import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import '../shared/component/Custom_text_filed.dart';

class ChangePassScr extends StatelessWidget {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  var changePasskey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body:Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key:changePasskey ,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :
                      [
                        if(state is ChangePassLoadingState)
                          Column(
                            children: [
                              LinearProgressIndicator(),
                              SizedBox(height: 20,),
                            ],
                          ),
                        Text('Current Password',style: TextStyle(fontSize: 15),),
                        defaulttextform(controller: currentPass, type: TextInputType.visiblePassword,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return'please enter your password';
                            }
                          },
                          hint: 'Enter Your current Password',
                          preficon: Icons.lock_outline,),
                        SizedBox(height: 40,),
                        Text('New Password',style: TextStyle(fontSize: 15),),
                        defaulttextform(controller: newPass, type: TextInputType.visiblePassword,
                          ispass: cubit.isPass,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return'please enter your password';
                            }
                          },
                          hint: 'Enter New Password',
                          preficon: Icons.lock_outline,
                          suficon: cubit.suffix,
                          sufixpress: (){
                            cubit.changePassVisiblity();
                          },),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton(
                              onPressed: (){
                                if(changePasskey.currentState!.validate())
                                {
                                  cubit.changeUserPass(old_pass: currentPass.text, new_pass: newPass.text, context: context);
                                }
                              },
                              child: Text('Change Password',),
                          ),
                        ),

                        SizedBox(height: 200,)


                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
