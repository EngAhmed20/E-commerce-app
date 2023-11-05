import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/Shop_Cubit/Shop_States.dart';
import 'package:shop_app/model/addressModel/addressModel.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/faqsModel.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/productModel.dart';
import 'package:shop_app/moduls/Cart_Scr.dart';
import 'package:shop_app/moduls/Favorites_Scr.dart';
import 'package:shop_app/moduls/Products_Scr.dart';
import 'package:shop_app/moduls/myAccountScr.dart';
import 'package:shop_app/network/end_points.dart';
import '../../model/Category_Details_Model.dart';
import '../../model/addressModel/addAddress_Model.dart';
import '../../model/addressModel/updateAddress_Model.dart';
import '../../model/cartModels/addCartModel.dart';
import '../../model/cartModels/cartModel.dart';
import '../../model/cartModels/updateCartModel.dart';
import '../../model/change_fav_model.dart';
import '../../model/contact_Model.dart';
import '../../model/login_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../shared/component/constant.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int CurrentIndex=0;
  List <Widget> bottomScr=[
    ProductScr(),
    CartScr(),
    FavoriteScr(),
    MyAccountScr(),
  ];
  void ChangeBottomNav(int index){
    CurrentIndex=index;
    emit(ShopChangeBottomNavState());
}
  bool change=false;
  void UpdateUserInfo(bool val){
    change=val;
    emit(ShopChangeInfoState());
  }
  ////open add details
  bool showDetails=false;
  void ShowAddDetail({required int? id}){
    showDetails=!showDetails;
    emit(ShopAddressDetail());
  }
  ///get home data
HomeModel? homeModel;
Map<dynamic,dynamic>favorites={};
Map <dynamic ,dynamic> cart = {};
  void getHomeData()
{
  emit(ShopHomeLoadingDataState());
  DioHelper.getData(url: Home,token:token, ).then((value){
    homeModel=HomeModel.fromJson(value.data);
    homeModel!.data!.products.forEach((element) {
      favorites.addAll(
        {
        element.id: element.in_fav
        }
      );
    });
    homeModel!.data!.products.forEach((element) {
      cart.addAll(
       {
         element.id:element.in_cart,
       }
      );
    });
    emit(ShopHomeSucessDataState());
  })
      .catchError((error){
        print(error.toString());
        emit(ShopHomeErrorDataState(error.toString()));
  });
}
///get categories
CategoriesModel? categoriesModel;
void GetCategories(){
  emit(ShopCategoriesLoadingDataState());
  DioHelper.getData(url: GET_CATEGORIES).then((value) {
    categoriesModel=CategoriesModel.fromJson(value.data);
    emit(ShopSucessCategoriesState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorCategoriesState(error));
  });
}
CategoryDetailModel? categoryDetailModel;
void GetCategoriesDetails(int? category_id){
emit(CategoryDetailsLoadingState());
DioHelper.getData(url: 'categories/$category_id')
    .then((value) {
  categoryDetailModel=CategoryDetailModel.fromJson(value.data);
  emit(CategoryDetailsSuccessState());
}).catchError((error){
  emit(CategoryDetailsErrorState());
  print(error.toString());
});
}
///change fav
  ChangeFavModel? changeFavModel;
void ChangeFavorites(int? productId)
{
  favorites[productId]=!favorites[productId];
  emit(ShopChangeFavoriteState());
  ///////////////////////////////////////
  DioHelper.postData(url: FAVORITES, data: {
   'product_id':productId,
  },token: token).then((value) {
    changeFavModel=ChangeFavModel.fromJson(value.data);
    if(changeFavModel!.status==false){
      favorites[productId]=!favorites[productId];
    }else{
      GetFavorites();
    }
    emit(ShopSucessFavoriteState(changeFavModel!));
  }).catchError((error){
    if(changeFavModel!.status==false){
      favorites[productId]=!favorites[productId];
    }
    emit(ShopErrorFavoriteState(error.toString()));

  });
}
///get fav
FavoritesModel? favoritesModel;
  void GetFavorites(){
    emit(ShopGetFavLoadingState());
    DioHelper.getData(url: FAVORITES,token: token).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopGetFavSucessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetFavErrorState(error));
    });
  }
///get user data
  ShopLoginModel? userModel;
  void GetUserData(){
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(url: PROFILE,token: token).then((value) {
      userModel=ShopLoginModel.fromJson(value.data);

      emit(ShopGetUserDataSucessState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetUserDataErrorState(error));
    });
  }
///update user data
  ShopLoginModel? updatemodel;
void UpdateUserData(
  {
  required String name,
    required String email,
    required String phone,

  }
    ){
emit(ShopUpdateUserLoadingDataState());
DioHelper.PutData(url: UPDATE,token: token, data: {
  'name':name,
  'email':email,
  'phone':phone,
}).then((value) {
  updatemodel=ShopLoginModel.fromJson(value.data);
  GetUserData();
  emit(ShopUpdateUserSucessState(updatemodel!));
}).catchError((error){
  emit(ShopUpdateUserErrorState(error.toString()));
});
}
///change pass
ShopLoginModel? changePassModel;
void changeUserPass({
  required String old_pass,
  required String new_pass,
  required context,
}){
emit(ChangePassLoadingState());
DioHelper.postData(url: CHANGEPASS, data: {
  'current_password':old_pass,
   'new_password':new_pass,},token: token).then((value){
     changePassModel=ShopLoginModel.fromJson(value.data);
     if(changePassModel!.status==true){
       showToast(changePassModel!.message, Colors.blue);
       Navigator.pop(context);
     }else
       showToast(changePassModel!.message, Colors.blue);
     emit(ChangePassSuccessState(changePassModel!));

}).catchError((error){
  emit(ChangePassErrorState());
  print(error.toString());
});
}
///change pass visablity
  IconData suffix= Icons.visibility_outlined;
  bool isPass=true;
  void changePassVisiblity()
  {
    isPass=!isPass;
    suffix=isPass ?Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(ChangePassVisiblityState());
  }

/////////////////product details
ProductDetailsModel? productDetailsModel;
void getProductDetails(productId){
  productDetailsModel = null;
  emit(ProductLoadingState());
  DioHelper.getData(url:'products/$productId',
  token: token,
  ).then((value) {
    productDetailsModel=ProductDetailsModel.fromJson(value.data);
    emit(ProductSuccessState());
  }).catchError((error){
    emit(ProductErrorState());
  });

}

/////////////////cart
late AddCartModel  addCartModel;
void addToCart(int? productID){
  emit(CartLoadingState());
  DioHelper.postData(url: CART,token: token ,data: {'product_id':productID})
      .then((value){
        addCartModel=AddCartModel.fromJson(value.data);
    if(addCartModel.status)
          { getCartData();
            getHomeData();
          }
     else
        showToast(addCartModel.message, Colors.blue);
     emit(AddCartSuccessState(addCartModel));

  }).catchError((error){
    emit(AddCartErrorState());

  });
}

late UpdateCartModel  updateCartModel;
void UpdateCartData(int? cartId,int? quantity){
  emit(UpdateCartLoadingState());
  DioHelper.PutData(url: 'carts/$cartId',token: token ,data: {
    'quantity':'$quantity',})
      .then((value) {
        updateCartModel =UpdateCartModel.fromJson(value.data);
        if(updateCartModel.status)
          getCartData();
        else
          showToast(updateCartModel.message,Colors.blue);
        print('Update Cart '+ updateCartModel.status.toString());
        emit(UpdateCartSuccessState());
  }).catchError((error){
    emit(UpdateCartErrorState());
  });
}
///CART
late CartModel  cartModel;
  void getCartData() {
    emit(CartLoadingState());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value){
      cartModel = CartModel.fromJson(value.data);
      emit(CartSuccessState());
    }).catchError((error){
      emit(CartErrorState());
    });
  }
  /// Q and A
  FAQsModel? faQsModel;
  void getFAQsData(){
    emit(FAQsLoadingState());
    DioHelper.getData(url: 'faqs').then((value){
      faQsModel=FAQsModel.fromJson(value.data);
      emit(FAQsSuccessState());
    }).catchError((error){
      emit(FAQsErrorState());
    });
}
///contact with dev
  ContactModel? contactModel;
  void getContactData(){
    emit(GetContactLoadingState());
    DioHelper.getData(url: CONTACT).then((value){
      contactModel=ContactModel.fromJson(value.data);
      emit(GetContactSuccessState());
    })
        .catchError((Error){
          emit(GetContactErrorState());
    });
  }
  ///Address
///Add address
  AddAddressModel? addAddressModel;
  void AddAddress({
  required String name,
  required String city,
  required String region,
  required String details,
  required String notes,
  double latitude = 30.0616863,
  double longitude = 31.3260088,})
{
  emit(AddAddressLoadingState());
  DioHelper.postData(url: ADDADDRESS,
      data:{
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },token: token).then((value){
        addAddressModel=AddAddressModel.fromJson(value.data);
        if(addAddressModel!.status)
          getAddresses();
        else
          showToast(addAddressModel!.message,Colors.blue);
        emit(AddAddressSuccessState(addAddressModel!));
  }).catchError((error){
    emit(AddAddressErrorState());

  });}
  AddressModel? getAddressModel;
  void getAddresses(){
    emit(GetAddressLoadingState());
    DioHelper.getData(url: ADDADDRESS,token: token,).
    then((value) {
      getAddressModel=AddressModel.fromJson(value.data);
      emit(GetAddressSuccessState(getAddressModel!));
    }).catchError((error){
      emit(GetAddressErrorState());
    });
  }
  ///updateAddress
  UpdateAddressModel? updateAddressModel;
  void UpdateAddressl({
    required int addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,})
  {
    emit(AddAddressLoadingState());
    DioHelper.PutData(url: 'addresses/$addressId',
        data:{
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        },token: token).then((value){
      updateAddressModel=UpdateAddressModel.fromJson(value.data);
      if(updateAddressModel!.status)
        getAddresses();
      else
        showToast(updateAddressModel!.message,Colors.blue);
      emit(UpdateAddressSuccessState(updateAddressModel!));
    }).catchError((error){
      emit(UpdateAddressErrorState());

    });}
///delete address
UpdateAddressModel ? deleteAddressModel;
  void deleteAddress({required addressId})
  {
    emit(DeleteAddressLoadingState());
    DioHelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value){
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      if(deleteAddressModel!.status)
        getAddresses();
      emit(DeleteAddressSuccessState());
    }).catchError((error){
      emit(DeleteAddressErrorState());
      print(error.toString());
    });
  }

}