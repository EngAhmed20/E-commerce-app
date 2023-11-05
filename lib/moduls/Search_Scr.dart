import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/search_cubit/SearchCubit.dart';
import 'package:shop_app/Cubit/search_cubit/SearchStates.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/moduls/productDetailsScr.dart';
import 'package:shop_app/shared/component/Custom_text_filed.dart';

import '../Cubit/Shop_Cubit/Shop_Cubit.dart';
import '../shared/component/constant.dart';

class SearchScr extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var SearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(BuildContext context)=>SearchCubit(),
    child: BlocConsumer<SearchCubit,SearchStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SearchCubit.get(context);
        return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    defaulttextform(controller: SearchController,
                        type:TextInputType.text,
                        validator: (String? value){
                      if(value!.isEmpty)
                        {
                          return 'enter text to search';
                        }
                      return null;
                        },
                        onSubmit: (String? value){
                          cubit.search(text: SearchController.text);
                        },
                        label: 'Search',
                        preficon: Icons.search),
                    SizedBox(height: 10,),
                    if(state is SearchSucessState)
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder:(context,index) =>BuildSearchItem(cubit.searchmodel!.data.data[index],context),
                                  separatorBuilder:(context,index)=> Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                  ),
                                  itemCount: cubit.searchmodel!.data.data.length),
                            ),
                ],
                ),
              ),
            )
        );
      },
    ),
    );
  }
  Widget BuildSearchItem(SearchProduct? model,context)=>InkWell(
    onTap:() {
      ShopCubit.get(context).getProductDetails(model.id);
      navigateTo(context, ProductDetailsScr());
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image(image: NetworkImage('${model!.image}'),width: 120,height: 120,),

                ],

              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Column(
                children: [
                  Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                    height: 1.4,
                  ),),
                  Spacer(),
                  Row(
                    children: [
                      Text('${model.price}'+'EGP',style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue
                      ),),

                      Spacer(),
                      IconButton(padding: EdgeInsets.all(0),
                        onPressed: (){
                          ShopCubit.get(context).ChangeFavorites(model.id);
                        }, icon: CircleAvatar(
                            radius:15,
                            backgroundColor:ShopCubit.get(context).favorites[model.id]? Colors.red:Colors.grey,
                            child: Icon(Icons.favorite_border,size: 18,color: Colors.white,)),),

                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );

}
