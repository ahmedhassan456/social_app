import 'package:chat_app/CacheHelper/CacheHelper.dart';
import 'package:chat_app/Dio_Helper/DioHelper.dart';
import 'package:chat_app/constant/constant.dart';
import 'package:chat_app/cubit/HomeCubit/HomeCubit.dart';
import 'package:chat_app/cubit/HomeCubit/HomeStates.dart';
import 'package:chat_app/layout/Login/LoginScreen.dart';
import 'package:chat_app/moduls/HomeScreen/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocObserver/BlocObserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  bool checkUid = false;
  String? getUId = CacheHelper.getData(key:'uId');
  uId = getUId;
  print(uId);
  if(uId != null){
    checkUid = true;
  }else{
    checkUid = false;
  }
  runApp(MyApp(uId: checkUid,));
}


class MyApp extends StatelessWidget {
  final bool uId;
  const MyApp({super.key,required this.uId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()..getUserData()..getPosts()..getUsersI()),
        ],
        child: MaterialApp(
          title: 'Chat APP',
          home: uId ? const HomeScreen() : const LoginScreen(),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedIconTheme: IconThemeData(
                color: Colors.amberAccent,
              ),
              selectedLabelStyle: TextStyle(
                color: Colors.white,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.white,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.amber,
              ),
            ),
            appBarTheme: const AppBarTheme(
              color: Colors.black26,
              actionsIconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0.0,
              color: Colors.white,
              actionsIconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      );
  }
}
