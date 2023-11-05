import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';

import '../model/faqsModel.dart';

class FAQsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        FAQsModel? model=ShopCubit.get(context).faQsModel;
        return Scaffold(
          appBar: AppBar(
            title:Center(child: Text('FAQs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),)),

          ),
          body:state is FAQsLoadingState? Center(child: CircularProgressIndicator(),):
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.separated(shrinkWrap: true,
                    itemBuilder: (context,index)=>BuildFAQItems(model!.data!.data![index],context),
                    separatorBuilder: (context,index)=>Container(),
                    itemCount: model!.data!.data!.length),
                ],
            ),
          ),
        );
      },
    );
  }
  Widget BuildFAQItems(FAQsData model,context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ExpansionTile(
          title: Text(
            ' ${model.question}',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black),
          ),
          children: [
            Text(
              '${model.answer}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 10,),

          ],
        ),

      ],
    ),
  );
}
