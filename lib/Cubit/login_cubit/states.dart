import '../../model/login_model.dart';

abstract class LoginState{}
class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSucessState extends LoginState{
  final ShopLoginModel loginModel;
  LoginSucessState(this.loginModel
  );
}
class LoginErrorState extends LoginState{
  final String error;

  LoginErrorState(this.error);

}

class ChangePassVisiblityState extends LoginState{}
