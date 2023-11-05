import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/moduls/update&new%20AddressScreen.dart';
import 'package:shop_app/shared/component/constant.dart';

import '../model/addressModel/addressModel.dart';

class AddressScr extends StatelessWidget {
  const AddressScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          bottomSheet: Container(
            width: double.infinity,
            height: 70,
            padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,

            ),
            child: MaterialButton(
              onPressed: (){
                navigateTo(context, UpdateAddressScr(isEdit: false,));
              },
              child: Text('Add a new address',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
            ),
          ),
          body:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>cubit.getAddressModel!.data!.data!.length==0?
                    Container() :AddressItem(cubit.getAddressModel!.data!.data![index],context),
                    separatorBuilder: (context,index)=> myDivider(),
                    itemCount: cubit.getAddressModel!.data!.data!.length)
              ],
            ),
          ),
        );
      },
    );
  }
  Widget AddressItem(AddressData model,context)
{
  return InkWell(
    onTap: (){
      ShopCubit.get(context).ShowAddDetail(id: model.id);
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,color: Colors.green,),
              SizedBox(width: 5,),
              Text ('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Spacer(),
              TextButton(onPressed: (){
                ShopCubit.get(context).deleteAddress(addressId: model.id);
              }, child: Row(
                children: [
                  Icon(Icons.delete),
                  Text('Delete this Address'),
                ],
              )),
              Container(height: 20,width: 1,color: Colors.cyan,),
              TextButton(onPressed: (){
                navigateTo(context, UpdateAddressScr(isEdit:true,
                  addressId: model.id,
                  name: model.name,
                  city: model.city,
                  region: model.region,
                  details: model.details,
                  notes: model.notes,

                ));
              }, child: Row(
                children: [
                  Icon(Icons.edit),
                  Text('edit'),
                ],
              )),
            ],
          ),
        ),
        if(ShopCubit.get(context).showDetails==true)
          Container(height: 200,width: double.infinity,color: Colors.grey[300],
            margin: EdgeInsets.only(left: 10,right: 10),
          padding: EdgeInsets.all(10),
            child: Row(
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Region',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Details',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Notes',style: TextStyle(fontSize: 15,color: Colors.grey),),
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${model.city}',style: TextStyle(fontSize: 15,)),
                    SizedBox(height: 10,),
                    Text('${model.region}',style: TextStyle(fontSize: 15,)),
                    SizedBox(height: 10,),
                    Text('${model.details}',style: TextStyle(fontSize: 15,)),
                    SizedBox(height: 10,),
                    Text('${model.notes}',style: TextStyle(fontSize: 15,)),
                    //
                  ],),
              ],
            ),
          ),
      ],
    ),
  );
}
}
