import 'package:bloc/bloc.dart';
import 'package:chat_app/models/userModel/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        uId: value.user!.uid,
        name: name,
        phone: phone,
        email: email,
      );
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  void createUser({
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    UserModel model = UserModel(
      email: email,
      uId: uId,
      name: name,
      phone: phone,
      bio: 'write your bio...',
      image: 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1060&t=st=1688785797~exp=1688786397~hmac=8c832ebf8b586fbbbc3b1c8e1e452604af2746721aeb9984f5f01733aa517f92',
      coverImage: 'https://img.freepik.com/free-photo/delicious-arabic-fast-food-meat-rolls-copy-space_23-2148651125.jpg?w=1060&t=st=1688789645~exp=1688790245~hmac=82ec7be897de8b5adb4ff186220a5b878deb31ba8b1f2f30d636683b07ea307b',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(CreateUserSuccessState());
    })
        .catchError((error) {
          emit(CreateUserErrorState(error: error.toString()));
    });
  }
}
