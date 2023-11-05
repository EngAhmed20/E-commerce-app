import 'package:shop_app/model/change_fav_model.dart';
import 'package:shop_app/model/login_model.dart';

import '../../model/addressModel/addAddress_Model.dart';
import '../../model/addressModel/addressModel.dart';
import '../../model/addressModel/updateAddress_Model.dart';
import '../../model/cartModels/addCartModel.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopChangeInfoState extends ShopStates{}
class ShopAddressDetail extends ShopStates{}

class ShopHomeLoadingDataState extends ShopStates{}
class ShopHomeSucessDataState extends ShopStates{}
class ShopHomeErrorDataState extends ShopStates{
  final String error;

  ShopHomeErrorDataState(this.error);
}
class ShopCategoriesLoadingDataState extends ShopStates{}
class ShopSucessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  final String error;

  ShopErrorCategoriesState(this.error);
}
class ShopSucessFavoriteState extends ShopStates{
  final ChangeFavModel model;

  ShopSucessFavoriteState(this.model);

}
class ShopErrorFavoriteState extends ShopStates{
  final String error;

  ShopErrorFavoriteState(this.error);
}
class ShopChangeFavoriteState extends ShopStates{}
class ShopGetFavLoadingState extends ShopStates{

}
class ShopGetFavSucessState extends ShopStates{

}
class ShopGetFavErrorState extends ShopStates{
  final String error;

  ShopGetFavErrorState(this.error);
}
class ShopGetUserDataLoadingState extends ShopStates{

}
class ShopGetUserDataSucessState extends ShopStates{
ShopLoginModel model;
ShopGetUserDataSucessState(this.model);
}
class ShopGetUserDataErrorState extends ShopStates{
  final String error;

  ShopGetUserDataErrorState(this.error);
}
class ShopUpdateUserLoadingDataState extends ShopStates{}
class ShopUpdateUserSucessState extends ShopStates{
  ShopLoginModel UpdateUserModel;
  ShopUpdateUserSucessState(this.UpdateUserModel);
}
class ShopUpdateUserErrorState extends ShopStates{
  final String error;

  ShopUpdateUserErrorState(this.error);
}
///Product State
class ProductLoadingState extends ShopStates{}
class ProductSuccessState extends ShopStates{}
class ProductErrorState extends ShopStates{}
///cart
class AddCartLoadingState extends ShopStates{}
class AddCartSuccessState extends ShopStates {
  final AddCartModel addCartModel;

  AddCartSuccessState(this.addCartModel);
}
class AddCartErrorState extends ShopStates{}
///End of Favorites State


///Cart State
class CartLoadingState extends ShopStates{}
class CartSuccessState extends ShopStates {}
class CartErrorState extends ShopStates{}
///End of Cart State

///Cart State
class UpdateCartLoadingState extends ShopStates{}
class UpdateCartSuccessState extends ShopStates {}
class UpdateCartErrorState extends ShopStates{}
class MinusCartItemState extends ShopStates{}
class PlusCartItemState extends ShopStates{}

class CategoryDetailsLoadingState extends ShopStates{}
class CategoryDetailsSuccessState extends ShopStates{}
class CategoryDetailsErrorState extends ShopStates{}
class FAQsLoadingState extends ShopStates{}
class FAQsSuccessState extends ShopStates {}
class FAQsErrorState extends ShopStates{}

class GetContactLoadingState extends ShopStates{}
class GetContactSuccessState extends ShopStates {}
class GetContactErrorState extends ShopStates{}
///ChangePassword State
class ChangePassLoadingState extends ShopStates{}
class ChangePassSuccessState extends ShopStates {
   ShopLoginModel changePassModel;
  ChangePassSuccessState(this.changePassModel);
}
class ChangePassErrorState extends ShopStates{}
class ChangePassVisiblityState extends ShopStates{}

///Add Address State
class AddAddressLoadingState extends ShopStates{}
class AddAddressSuccessState extends ShopStates {
  final AddAddressModel addAddressModel;
  AddAddressSuccessState(this.addAddressModel);
}
class AddAddressErrorState extends ShopStates{}
///get Address
class GetAddressLoadingState extends ShopStates{}
class GetAddressSuccessState extends ShopStates {
  final AddressModel getAddressModel;
  GetAddressSuccessState(this.getAddressModel);
}
class GetAddressErrorState extends ShopStates{}
///update Address
class UpdateAddressLoadingState extends ShopStates{}
class UpdateAddressSuccessState extends ShopStates {
  final UpdateAddressModel updateAddressModel;
  UpdateAddressSuccessState(this.updateAddressModel);
}
class UpdateAddressErrorState extends ShopStates{}
///delete
class DeleteAddressLoadingState extends ShopStates{}
class DeleteAddressSuccessState extends ShopStates {}
class DeleteAddressErrorState extends ShopStates{}