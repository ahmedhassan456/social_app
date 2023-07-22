abstract class HomeStates{}
class HomeInitialState extends HomeStates{}

// get user info
class HomeGetUserSuccessState extends HomeStates{}
class HomeGetUserErrorState extends HomeStates{
  final String? error;
  HomeGetUserErrorState(this.error);
}
class HomeGetUserLoadingState extends HomeStates{}

// Bottom Nav Bar
class HomeChangeBottomNav extends HomeStates{}

// new post
class HomeNewPost extends HomeStates{}

// image picker
class HomeProfileImagePickedSuccess extends HomeStates{}
class HomeProfileImagePickedError extends HomeStates{}
class HomeCoverImagePickedSuccess extends HomeStates{}
class HomeCoverImagePickedError extends HomeStates{}

// upload images
class HomeUploadProfileImageSuccess extends HomeStates{}
class HomeUploadProfileImageError extends HomeStates{}
class HomeUploadCoverImageSuccess extends HomeStates{}
class HomeUploadCoverImageError extends HomeStates{}
class HomeUpdateCoverImageError extends HomeStates{}

// create post
class HomeLoadingUpdateUserData extends HomeStates{}
class HomeLoadingCreatePostState extends HomeStates{}
class HomeSuccessCreatePostState extends HomeStates{}
class HomeErrorCreatePostState extends HomeStates{}

// get post image
class HomePostImagePickedSuccessState extends HomeStates{}
class HomePostImagePickedErrorState extends HomeStates{}

// remove post image
class HomeRemovePostImageState extends HomeStates{}