abstract class LoginStates {}
class LoginInitialState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  dynamic uId;
  LoginSuccessState(uId);
}
class LoginErrorState extends LoginStates{
  String? error;
  LoginErrorState(error);
}
class LoginLoadingState extends LoginStates{}
