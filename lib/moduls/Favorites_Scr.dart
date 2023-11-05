import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/model/favorites_model.dart';

class FavoriteScr extends StatelessWidget {
  const FavoriteScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(condition: state is! ShopGetFavLoadingState,
            builder:(context)=>ListView.separated(
                itemBuilder: (context,index)=>buildFavoriteItems(ShopCubit.get(context).favoritesModel!.data.data[index].product,context),
                separatorBuilder: (context,index)=>Container(height: 1,color: Colors.grey[300],),
                itemCount:ShopCubit.get(context).favoritesModel!.data.data.length),
            fallback:(context)=> Center(child: CircularProgressIndicator(),));
      },
    );
  }



  Widget buildFavoriteItems(FavoriteProduct? model,context)=>Padding(
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
                Image(image: NetworkImage('${model!.image}'),width: 120,height: 120,fit: BoxFit.cover,),
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
                    Text('${model.price}',style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue
                    ),),
                    SizedBox(width: 15,),
                    if(model.discount!=0)
                      Text('${model.oldPrice}',style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough,
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
  );
}
