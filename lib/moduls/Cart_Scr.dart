import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/model/cartModels/cartModel.dart';
import 'package:shop_app/moduls/productDetailsScr.dart';
import 'package:shop_app/shared/component/paymnt/payment_manager.dart';

import '../shared/component/constant.dart';

class CartScr extends StatelessWidget {
  TextEditingController counterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        CartModel cartModel=ShopCubit.get(context).cartModel;
        double total=cartModel.data!.total;
        int money=total.round();
        cartLength=ShopCubit.get(context).cartModel!.data!.cartItems.length;
        return cubit.cartModel.data!.cartItems.length ==0 ?Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag_outlined,size: 70,color: Colors.greenAccent,),
              SizedBox(height: 10,),
              Text('Your Cart is empty',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Be Sure to fill your cart with something you like',style: TextStyle(fontSize: 15 ))
            ],

          ),
        )
            :SingleChildScrollView(
          physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(itemBuilder: (context,index)=>CartProduct(cartModel.data!.cartItems[index], context),
                      separatorBuilder:(context,index)=> myDivider(),
                      shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                      itemCount: cartLength),
                  Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(children: [
                          Text('sub total '+'( $cartLength items )'),
                          Spacer(),
                          Text('EGP'+'${cartModel.data!.subTotal}'),
                        ],),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                          Text('Shipping Free '),
                          Spacer(),
                        ],),
                        SizedBox(height: 20,),
                        Row(
                          //textBaseline: TextBaseline.alphabetic,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('TOTAL',style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(' Inclusive of VAT',style: TextStyle(fontSize: 10,color: Colors.grey,fontStyle: FontStyle.italic),),
                            Spacer(),
                            Text('EGP '+'${cartModel.data!.total}',style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(width: double.infinity,height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child:
                    ElevatedButton(
                      onPressed: (){paymentManager.makePayment(money, "EGP");},
                      child: Text('Pay Now',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.bold),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>( Colors.red),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ))
                      ),
                    ),),

                  SizedBox(height: 20,),

                ],
              ),
            );

      },
    );
  }

  Widget CartProduct(CartItems model,context)
  {
    //counterController.text = '${model!.quantity}';
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getProductDetails(model.product!.id);
        navigateTo(context, ProductDetailsScr());
      },
      child: Container(
        height: 180,
          margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              height: 120,
              child: Row(
                children: [
                  Image(image: NetworkImage('${model.product!.image}'),width: 100,height: 100,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${model.product!.name}',style: TextStyle(fontSize: 15),
                        maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Spacer(),
                        Text('EGP '+'${model.product!.price}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        if(model.product!.discount != 0)
                          Text('EGP'+'${model.product!.oldPrice}',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
                      ],
                    ),

                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: MaterialButton(
                          onPressed: (){
                            int quentity=model.quantity!-1;
                            if(quentity!=0)
                              ShopCubit.get(context).UpdateCartData(model.id, quentity);
                          },
                          child: Icon(Icons.dangerous,size: 20,color: Colors.deepOrange,),
                          minWidth: 20,padding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text('${model.quantity}',style: TextStyle(fontSize: 20),),
                      SizedBox(width: 10,),
                      Container(
                        width: 20,
                        height: 20,
                        child: MaterialButton(
                          onPressed: (){
                            int quantity = model.quantity!+1;
                              ShopCubit.get(context).UpdateCartData(model.id, quantity);
                          },child: Icon(Icons.add,size: 17,color: Colors.green[500],),
                          minWidth: 20,
                          padding: EdgeInsets.zero,

                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
            Row(children: [
              IconButton(
                onPressed: (){
                  ShopCubit.get(context).ChangeFavorites(model.product!.id);
                }, icon: CircleAvatar(
                    radius:15,
                    backgroundColor:ShopCubit.get(context).favorites[model.product!.id]? Colors.red:Colors.grey,
                    child: Icon(Icons.favorite_border,size: 18,color: Colors.white,)),),
              SizedBox(width: 5,),
              Container(height: 20,width: 1,color: Colors.grey[300],),
              TextButton(
                  onPressed: ()
                  {
                    ShopCubit.get(context).addToCart(model.product!.id);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline_outlined,color: Colors.grey,size: 18,),
                      SizedBox(width: 2.5,),
                      Text('Remove',style: TextStyle(color: Colors.grey,fontSize: 13,)),
                    ],
                  )
              ),
            ],),


          ],
        ),
      ),
    );
  }
}