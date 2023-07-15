import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/HomeCubit/HomeStates.dart';
import 'package:chat_app/models/userModel/userModel.dart';
import 'package:chat_app/moduls/New_Post/NewPost.dart';
import 'package:chat_app/moduls/chats/chats_screen.dart';
import 'package:chat_app/moduls/feeds/feeds_screen.dart';
import 'package:chat_app/moduls/users/user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../constant/constant.dart';
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
      emit(HomeProfileImagePickedSuccess());
    } else {
      print('no image selected');
      emit(HomeProfileImagePickedError());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        profileImageUrl = value;
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

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value.toString());
        coverImageUrl = value;
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

  void updateUserImages({
    required String name,
    required String phone,
    required String bio,
}) {
    emit(HomeUpdateUserData());

    if(coverImage != null){
      uploadCoverImage();
    }else if(profileImage != null){
      uploadProfileImage();
    }else if(coverImage != null && profileImage != null){

    }else{
      updateUser(
        phone: phone,
        name: name,
        bio: bio,
      );
    }


  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
}){
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: model?.image,
      isEmailVerified: false,
      email: model?.email,
      uId: model?.uId,
      coverImage: model?.coverImage,
    );

    FirebaseFirestore.instance
      .collection('users')
      .doc(model?.uId)
      .update(userModel.toMap())
      .then((value) {
        getUserData();
      })
      .catchError((error) {
        emit(HomeUpdateCoverImageError());
      });

  }


}
