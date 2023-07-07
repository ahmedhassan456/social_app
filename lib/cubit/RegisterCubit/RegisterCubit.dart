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
