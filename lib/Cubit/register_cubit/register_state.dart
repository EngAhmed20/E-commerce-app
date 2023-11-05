

import '../../model/login_model.dart';

abstract class RegisterState{}
class RegisterInitialState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSucessState extends RegisterState{
  final ShopLoginModel registermodel;
  RegisterSucessState(this.registermodel);
}
class RegisterErrorState extends RegisterState{
  final String error;

  RegisterErrorState(this.error);

}

class ChangePassVisiblityState extends RegisterState{}
