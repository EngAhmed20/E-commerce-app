import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_Cubit.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';

import '../shared/component/Custom_text_filed.dart';

class UpdateAddressScr extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int ?addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;
  UpdateAddressScr({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
       return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions:
            [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('CANCEL',style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
          body:Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: addressFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(state is AddAddressLoadingState||state is UpdateAddressLoadingState)
                        Column(
                          children: [
                            LinearProgressIndicator(),
                            SizedBox(height: 20,),
                          ],
                        ),
                      Text('LOCATION INFORMATION',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      Text('Name',style: TextStyle(fontSize: 15),),
                      defaulttextform(controller: nameControl, type: TextInputType.name,
                          validator: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return'This field cant be Empty';
                            }
                          },
                        hint : 'Please enter your Location name',
                         ),
                      SizedBox(height: 40,),
                      Text('City',style: TextStyle(fontSize: 15),),
                      defaulttextform(controller: cityControl, type: TextInputType.name,
                        validator: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return'This field cant be Empty';
                          }
                        },
                        hint : 'Please enter your City name',
                      ),
                      SizedBox(height: 40,),
                      Text('Region',style: TextStyle(fontSize: 15),),
                      defaulttextform(controller: regionControl, type: TextInputType.name,
                        validator: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return'This field cant be Empty';
                          }
                        },
                        hint : 'Please enter your region',
                      ),
                      SizedBox(height: 40,),
                      Text('Details',style: TextStyle(fontSize: 15),),
                      defaulttextform(controller: detailsControl, type: TextInputType.name,
                        validator: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return'This field cant be Empty';
                          }
                        },
                        hint : 'Please enter some details',
                      ),
                      SizedBox(height: 40,),
                      Text('Notes',style: TextStyle(fontSize: 15),),
                      defaulttextform(controller: notesControl, type: TextInputType.name,
                        validator: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return'This field cant be Empty';
                          }
                        },
                        hint : 'Please enter some notes to help find you',
                      ),
                      SizedBox(height: 60,),
                      Container(
                        width: double.infinity,
                        height: 70,
                        padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[300],

                        ),
                        child: MaterialButton(
                          onPressed: (){
                            if(addressFormKey.currentState!.validate())
                              {
                                if(isEdit==true)
                                  {
                                    ShopCubit.get(context).UpdateAddressl(addressId:
                                    addressId!,
                                        name: nameControl.text,
                                        city: cityControl.text,
                                        region: regionControl.text,
                                        details: detailsControl.text,
                                        notes: notesControl.text);
                                  }
                                else{
                                  ShopCubit.get(context).AddAddress(
                                      name: nameControl.text,
                                      city: cityControl.text,
                                      region: regionControl.text,
                                      details: detailsControl.text,
                                      notes: notesControl.text
                                  );
                                }
                                Navigator.pop(context);
                              }
                          },
                          child: Text('Save',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                        ),
                      ),




                    ],



              ),
            ),
          ),
        ),

       );
      },
    );
  }
}
