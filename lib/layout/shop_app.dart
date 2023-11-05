import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/moduls/Search_Scr.dart';
import 'package:shop_app/moduls/login_scr.dart';
import 'package:shop_app/network/local/shared_pref/cache_helper.dart';
import 'package:shop_app/shared/component/constant.dart';

import '../Cubit/Shop_Cubit/Shop_States.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =ShopCubit.get(context);
       return Scaffold(
         backgroundColor: Colors.white,
          appBar:AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                Image(image: AssetImage('assets/images/shop_logo.jpg'),width: 100,height: 100,),
                RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Fast',style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold)),
                          TextSpan(text: ' Shop',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)),
                        ]
                    )
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScr());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: cubit.bottomScr[cubit.CurrentIndex],
         bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.CurrentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:Colors.blue,
       unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor:Colors.white,
           onTap: (index){
             cubit.ChangeBottomNav(index);
           },
           items: [
             BottomNavigationBarItem(icon:Icon(Icons.home), label: 'Home'),
             BottomNavigationBarItem(icon:Icon(Icons.shopping_cart), label: 'Cart'),
             BottomNavigationBarItem(icon:Icon(Icons.favorite), label: 'Favorites'),
             BottomNavigationBarItem(icon:Icon(Icons.person), label: 'My Account'),

           ],
         ),
        );
      },
    );
  }
}
