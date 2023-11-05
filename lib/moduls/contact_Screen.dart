import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/contact_Model.dart';

class ContactScr extends StatelessWidget {
  const ContactScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder:(context,state){
          var cubit =ShopCubit.get(context);
     return Scaffold(
        appBar:AppBar(
          title: Row(
            children: [
              Image(image: AssetImage('assets/images/shop_logo.jpg'),width: 50,height: 50,),
              Text('Contact With Us')
            ],
          ),
        ) ,
        body:ConditionalBuilder(condition: cubit.contactModel!=null,
        builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ListView.separated(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index)=>ContactItem(cubit.contactModel!.data!.data![index]),
                separatorBuilder: (context,index)=>Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                itemCount: cubit.contactModel!.data!.data!.length)
        ),
        fallback:(context)=> Center(child: CircularProgressIndicator()),
        )
     );
    }, listener:(context,state){}
    );
  }
  Widget ContactItem(DataModel model)=>InkWell(
    onTap: ()async{

      await launch('${model.value}');

    },
    child: Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.only(bottom: 20,top: 10),
      child: Row(
        children: [
          Image(image: NetworkImage('${model!.image}'),color: Colors.blue,),

        ],
      ),
    ),

  );
}
