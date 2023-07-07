abstract class HomeStates{}
class HomeInitialState extends HomeStates{}


class HomeGetUserSuccessState extends HomeStates{}
class HomeGetUserErrorState extends HomeStates{
  final String? error;
  HomeGetUserErrorState(this.error);

}
class HomeGetUserLoadingState extends HomeStates{}

class HomeChangeBottomNav extends HomeStates{}

class HomeNewPost extends HomeStates{}
