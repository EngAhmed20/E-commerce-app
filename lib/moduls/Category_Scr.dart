import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/model/Category_Details_Model.dart';
import 'package:shop_app/moduls/productDetailsScr.dart';
import 'package:shop_app/shared/component/constant.dart';
class CategoryProductsScreen extends StatelessWidget {
  final String? categoryName;
  final String? categoryCover;
  CategoryProductsScreen(this.categoryName,this.categoryCover);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =ShopCubit.get(context);
        CategoryDetailModel? model =cubit.categoryDetailModel;
       return ConditionalBuilder(condition: cubit.categoryDetailModel!=null,
         builder: (BuildContext context)=> Scaffold(
         appBar: AppBar(
         titleSpacing: 0,
         title: Row(
           children: [
             Image(image: AssetImage('assets/images/shop_logo.jpg'),width: 50,height: 50,),
             SizedBox(width: 10,),
             Text('Fast Shop'),
           ],
         ),
       ),
        body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
        children: [
        Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        child: Image(image: NetworkImage('${categoryCover}'),width: double.infinity,height: 200,fit: BoxFit.fill,)
        ),
        SizedBox(height: 10,),
        Container(child: Text('$categoryName',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
        SizedBox(height: 10,),
        ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder:(context,index) =>buildCategoryProduct(cubit.categoryDetailModel!.data.data[index],context),
        separatorBuilder:(context,index)=> Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
        ),
        itemCount: cubit.categoryDetailModel!.data.data.length),
        ],
        ),
        ),
        ),
         fallback: (context)=>Center(child: CircularProgressIndicator(),),


       );

      },
    );
  }
  Widget buildCategoryProduct(ProductData model,context)=>InkWell(
    onTap: (){
      ShopCubit.get(context).getProductDetails(model.id);
      navigateTo(context, ProductDetailsScr());
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image(image: NetworkImage('${model.image}'),width: double.infinity,height: 200,),
              if(model.discount!=0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text('Discount',style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),),),
            ],

          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
              height: 1.4,
            ),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text('EGP '+'${model.price.round()}',style: TextStyle(
                    fontSize: 14,
                    color: Colors.black
                ),),
                SizedBox(width: 15,),
                if(model.discount!=0)
                  Column(
                    children: [
                      Text('${model.oldPrice.round()}',style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),),
                      SizedBox(width: 5,),
                      Text('${model.discount}% OFF',style: TextStyle(color: Colors.red),),
                    ],
                  ),
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
          ),


        ],
      ),
    ),
  );

}
