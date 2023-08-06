import 'package:chat_app/CacheHelper/CacheHelper.dart';
import 'package:chat_app/cubit/LoginCubit/LoginCubit.dart';
import 'package:chat_app/cubit/LoginCubit/LoginStates.dart';
import 'package:chat_app/modules/HomeScreen/HomeScreen.dart';
import 'package:chat_app/modules/RegisterScreen/RegisterScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constant/constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            Fluttertoast.showToast(
              msg: state.error!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: LoginCubit.get(context).uId.toString())
                .then((value) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
            });
          }
        },
        builder: (context, state) =>
            Scaffold(
              appBar: AppBar(
                elevation: 0.0,
              ),
              body: Center(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login Screen',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                          const SizedBox(height: 15.0,),
                          const Text(
                            'this is login screen',
                          ),
                          const SizedBox(height: 20.0,),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field must not be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              label: Text('email'),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field must not be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.key),
                              label: Text('password'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState ,
                            builder: (context) => Container(
                              width: double.infinity,
                              height: 40.0,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text,);
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            fallback: (context) => const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("doesn't have an email? "),
                              const SizedBox(width: 10.0,),
                              TextButton(onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (
                                        context) => const RegisterScreen()));
                              }, child: const Text('Register now'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
