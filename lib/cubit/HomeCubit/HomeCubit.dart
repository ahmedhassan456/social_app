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

import '../../constant/constant.dart';
import '../../moduls/settings/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          model = UserModel.fromJson(value.data()!);
          emit(HomeGetUserSuccessState());
    })
        .catchError((error) {
          print(error.toString());
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
  List<String> titles = [
    'Home',
    'Chats',
    'gcfc',
    'Users',
    'Settings'
  ];
  var currentIndex = 0;
  void changeNavBar({
    required int index,
}){
    if(index == 2){
      emit(HomeNewPost());
    }else{
      currentIndex = index;
      emit(HomeChangeBottomNav());
    }
  }
}
