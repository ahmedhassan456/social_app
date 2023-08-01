import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/HomeCubit/HomeStates.dart';
import 'package:chat_app/models/MessageModel/MessageModel.dart';
import 'package:chat_app/models/userModel/userModel.dart';
import 'package:chat_app/moduls/New_Post/NewPost.dart';
import 'package:chat_app/moduls/users/user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../constant/constant.dart';
import '../../models/PostModel/PostModel.dart';
import '../../moduls/chatsScreen/chats_screen.dart';
import '../../moduls/feedsScreen/feeds_screen.dart';
import '../../moduls/settings/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      print(model);
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      print('error-------: ${error.toString()}');
      emit(HomeGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = ['Home', 'Chats', 'New Post', 'Users', 'Settings'];
  var currentIndex = 0;

  void changeNavBar({
    required int index,
  }) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(HomeNewPost());
    } else {
      currentIndex = index;
      emit(HomeChangeBottomNav());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(HomeProfileImagePickedSuccess());
    } else {
      print('no image selected');
      emit(HomeProfileImagePickedError());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomeCoverImagePickedSuccess());
    } else {
      print('no image selected');
      emit(HomeCoverImagePickedError());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        profileImageUrl = value;
        updateUserData(name: name, phone: phone, bio: bio, image: value);
        emit(HomeUploadProfileImageSuccess());
      }).catchError((error) {
        print('error------- ${error.toString()}');
        emit(HomeUploadProfileImageError());
      });
    }).catchError((error) {
      print('error------------ ${error.toString()}');
      emit(HomeUploadProfileImageError());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        coverImageUrl = value;
        updateUserData(name: name, phone: phone, bio: bio, coverImage: value);
        emit(HomeUploadCoverImageSuccess());
      }).catchError((error) {
        print('error------- ${error.toString()}');
        emit(HomeUploadCoverImageError());
      });
    }).catchError((error) {
      print('error------------ ${error.toString()}');
      emit(HomeUploadCoverImageError());
    });
  }

//   void updateUserInfo({
//     required String name,
//     required String phone,
//     required String bio,
// }) {
//     emit(HomeLoadingUpdateUserData());
//
//     if(coverImage != null){
//       uploadCoverImage();
//     }
//     if(profileImage != null){
//       uploadProfileImage();
//     }
//     if(true){
//       updateUserData(
//         phone: phone,
//         name: name,
//         bio: bio,
//       );
//     }
//
//
//   }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? coverImage,
  }) {
    emit(HomeLoadingUpdateUserData());

    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? model?.image,
      isEmailVerified: false,
      email: model?.email,
      uId: model?.uId,
      coverImage: coverImage ?? model?.coverImage,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(HomeUpdateCoverImageError());
    });
  }

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(HomePostImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(HomePostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(HomeRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(HomeLoadingCreatePostState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        createNewPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        print('error------- ${error.toString()}');
        emit(HomeErrorCreatePostState());
      });
    }).catchError((error) {
      print('error------------ ${error.toString()}');
      emit(HomeErrorCreatePostState());
    });
  }

  void createNewPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(HomeLoadingCreatePostState());

    PostModel postModel = PostModel(
      name: model?.name,
      dateTime: dateTime,
      text: text,
      image: model?.image,
      uId: model?.uId,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(HomeSuccessCreatePostState());
    }).catchError((error) {
      emit(HomeErrorCreatePostState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(HomeGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(HomeGetPostsSuccessState());
    }).catchError((error) {
      print('error--------- ${error.toString()}');
      emit(HomeGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model?.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(HomeLikePostSuccessState());
    }).catchError((error) {
      emit(HomeLikePostErrorState());
    });
  }

  List<UserModel> users = [];

  void getUsers() {

    if(users.isEmpty){
      emit(HomeGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {

          if (element.data()['uId'] != model?.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(HomeGetAllUsersSuccessState());
      }).catchError((error) {
        print('Error---------- ${error.toString()}');
        emit(HomeGetAllUsersErrorState());
      });
    }

  }

  // send
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
}){
    MessageModel messageModel = MessageModel(
      senderId: model?.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );

    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
          emit(HomeSendMessagesSuccessState());
    })
        .catchError((error){
          print('error-------- ${error.toString()}');
          emit(HomeSendMessagesErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model?.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(HomeSendMessagesSuccessState());
    })
        .catchError((error){
      print('error-------- ${error.toString()}');
      emit(HomeSendMessagesErrorState());
    });
  }
}
