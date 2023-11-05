import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/layout/shop_app.dart';
import 'package:shop_app/model/productModel.dart';
import 'package:shop_app/moduls/Cart_Scr.dart';
import 'package:shop_app/moduls/Products_Scr.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScr extends StatelessWidget {
  PageController productImages = PageController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context,state){},
    builder: (context,state){
      ProductDetailsData? model= ShopCubit.get(context).productDetailsModel?.data;
      return Scaffold(
        key: scaffoldKey,
        appBar:AppBar(
            titleSpacing: 0,
            title: Row(children: [
              Image(image: AssetImage('assets/images/shop_logo.jpg'),width: 100,height: 100,),
              Text('Fast Shop'),
            ],)

        ),
        body:state is ProductLoadingState?Center(child: CircularProgressIndicator(),) :
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text('${model!.name}',style: TextStyle(fontSize: 20),),
                    ),
                    Container(
                      height: 400,
                      width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          PageView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: productImages,
                            itemBuilder: (context,index)=>Image(image: NetworkImage(
                              '${model.images![index]}'
                            )),
                            itemCount: model.images!.length,
                          ),
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
                    SizedBox(height: 10,),
                    SmoothPageIndicator(
                      controller: productImages,
                      count: model.images!.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.deepOrange,
                        spacing: 10,
                        dotWidth: 10,
                        dotHeight: 10,
                        expansionFactor: 4,

                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('EGP '
                            ''+ '${model.price}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        if(model.discount!=0)
                          Row(
                            children: [
                              Text('EGP'+'${model.oldPrice}',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                              SizedBox(width: 5,),
                              Text('${model.discount}% OFF',style: TextStyle(color: Colors.red),),
                            ],
                          ),
                        SizedBox(height: 15,),
                        myDivider(),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text('FREE delivery by ',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                            Text('${getDateTomorrow()}'),
                          ],
                        ),
                        SizedBox(height: 15,),
                        myDivider(),
                        SizedBox(height: 15,),
                        Text('Offer Details',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        Row(children: [
                          Icon(Icons.check_circle_outline,color: Colors.green),
                          SizedBox(width: 5,),
                          Text('Enjoy free returns with this offer'),
                        ],),
                        SizedBox(height: 15,),
                        myDivider(),
                        SizedBox(height: 15,),
                        Row(children: [
                          Icon(Icons.check_circle_outline,color: Colors.green),
                          SizedBox(width: 5,),
                          Text('1 Year warranty'),
                        ],),
                        SizedBox(height: 15,),
                        myDivider(),
                        SizedBox(height: 15,),
                        Row(children: [
                          Icon(Icons.check_circle_outline,color: Colors.green,),
                          SizedBox(width: 5,),
                          Text('Sold by Fast Shop'),
                        ],),
                        SizedBox(height: 15,),
                        myDivider(),
                        SizedBox(height: 15,),
                        Text('Overview',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                        SizedBox(height: 15,),
                        Text('${model.description}'),
                        SizedBox(height: 20,),
                      ],
                    ),
                    Container(width: double.infinity,height: 40,),

                  ],
                ),
              ),
            ),
            Container(width: double.infinity,
            height: 60,
              color: Colors.white,
              child: ElevatedButton(
                onPressed: (){
                  if(ShopCubit.get(context).cart[model.id]){
                    showToast('Already in Your Cart \nCheck Your Cart To Edit or Delete', Colors.blue);
                  }
                  else{
                    ShopCubit.get(context).addToCart(model.id);
                    scaffoldKey.currentState!.showBottomSheet((context)=>Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle,color: Colors.green,size: 18,),
                              SizedBox(width: 20,),
                              Expanded(child: Column(children: [
                                Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,),
                                SizedBox(height: 5,),
                                Text('Added to Your Cart',style: TextStyle(color: Colors.grey, fontSize: 13),),
                              ],))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(onPressed: (){navigateTo(context, ShopLayout());
                            ShopCubit.get(context).CurrentIndex = 0;}, child:Text('CONTINUE SHOPPING') ),
                            SizedBox(width: 10,),
                            ElevatedButton(onPressed: (){
                              navigateTo(context, ShopLayout());
                              ShopCubit.get(context).CurrentIndex = 1;
                            }, child: Text('Check Out')),
                          ],
                          ),
                        ],
                      ),
                    ));
                  }
                }, child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  SizedBox(width: 10,),
                  Text('Add to Cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              ),
            ),
          ],
        )
      );

    },
  );

  }
}
