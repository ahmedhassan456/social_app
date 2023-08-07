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

// get posts
class HomeGetPostsSuccessState extends HomeStates{}
class HomeGetPostsErrorState extends HomeStates{
  final String? error;
  HomeGetPostsErrorState(this.error);
}
class HomeGetPostsLoadingState extends HomeStates{}

// post likes
class HomeLikePostSuccessState extends HomeStates{}
class HomeLikePostErrorState extends HomeStates{}

// post comment
class HomeSetCommentPostSuccessState extends HomeStates{}
class HomeSetCommentPostErrorState extends HomeStates{}

//get comments
class HomeGetCommentPostSuccessState extends HomeStates{}
class HomeGetCommentPostErrorState extends HomeStates{}

// get All Users
class HomeGetAllUsersLoadingState extends HomeStates{}
class HomeGetAllUsersSuccessState extends HomeStates{}
class HomeGetAllUsersErrorState extends HomeStates{}

// send and get messages
class HomeSendMessagesSuccessState extends HomeStates{}
class HomeSendMessagesErrorState extends HomeStates{}
class HomeGetMessagesSuccessState extends HomeStates{}

//get usersI
class HomeGetAllUsersILoadingState extends HomeStates{}
class HomeGetAllUsersISuccessState extends HomeStates{}
class HomeGetAllUsersIErrorState extends HomeStates{}

// change app mood
class HomeChangeAppMoodState extends HomeStates{}

// refresh
class HomeRefreshPostsState extends HomeStates{}

// change index
class HomeChangeIndexState extends HomeStates{}