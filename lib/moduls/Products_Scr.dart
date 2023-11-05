
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/moduls/Category_Scr.dart';
import 'package:shop_app/moduls/productDetailsScr.dart';
import 'package:shop_app/shared/component/constant.dart';

class ProductScr extends StatelessWidget {
  const ProductScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopHomeSucessDataState)
          cartLength = ShopCubit.get(context).cartModel.data!.cartItems.length;
        if(state is ShopSucessFavoriteState)
          {
            if(state!.model!.status==false)
              {
                showToast(state!.model.message, Colors.red);

              }
          }
      },
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
        condition: cubit.homeModel!=null && cubit.categoriesModel!=null ,
          builder: (context)=>productsBuilder(cubit.homeModel!,cubit.categoriesModel!,context),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel catModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CarouselSlider(items:model.data!.banners.map((e)=>
      Image(image: NetworkImage('${e.img}'),width: double.infinity,fit: BoxFit.cover,))
          .toList(),
          options: CarouselOptions(
            height: 200,
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
          )),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Container(
              height: 100,
              child: ListView.separated(itemBuilder:(context,index)=> buildCategorieItem(catModel.data!.data[index],context),
                separatorBuilder: (context,index)=>SizedBox(width: 10),
                itemCount:catModel.data!.data.length,scrollDirection: Axis.horizontal,
              physics:BouncingScrollPhysics(),),
            ),
            SizedBox(height: 20,),
            Text('New Products',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          ],
        ),
      ),

      Container(
        color: Colors.grey[300],
        child: GridView.count(crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1/1.59,
        children:List.generate(model.data!.products.length,
                (index) =>buildGridProduct(model.data!.products[index],context)),
        ),
      ),

    ],),
  );
  Widget buildGridProduct(ProductModel model,context)=>InkWell(
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
              Image(image: NetworkImage('${model.img}'),width: double.infinity,height: 200,),
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
          Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
            height: 1.4,
          ),),
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
                      Text('${model.old_price.round()}',style: TextStyle(
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
  Widget buildCategorieItem(DataModel model,context)=>InkWell(
    onTap: (){
      ShopCubit.get(context).GetCategoriesDetails(model.id);
      navigateTo(context, CategoryProductsScreen(model.name,model.image));
    },
    child: Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
    Image(image: NetworkImage('${model.image}')
    ,width: 100,height: 100,fit: BoxFit.cover,),
    Container(
    width: 100,
    color: Colors.black.withOpacity(0.7),
    child: Text('${model.name}',style: TextStyle(color: Colors.white),
    textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 1,)),
    ],
    ),
  );

}
