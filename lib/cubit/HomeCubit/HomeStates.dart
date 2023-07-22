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

class HomeProfileImagePickedSuccess extends HomeStates{}
class HomeProfileImagePickedError extends HomeStates{}

class HomeCoverImagePickedSuccess extends HomeStates{}
class HomeCoverImagePickedError extends HomeStates{}

class HomeUploadProfileImageSuccess extends HomeStates{}
class HomeUploadProfileImageError extends HomeStates{}
class HomeUploadCoverImageSuccess extends HomeStates{}
class HomeUploadCoverImageError extends HomeStates{}

class HomeUpdateCoverImageError extends HomeStates{}

class HomeLoadingUpdateUserData extends HomeStates{}