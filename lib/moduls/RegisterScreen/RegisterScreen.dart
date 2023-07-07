import 'package:chat_app/cubit/LoginCubit/LoginCubit.dart';
import 'package:chat_app/layout/Login/LoginScreen.dart';
import 'package:chat_app/moduls/HomeScreen/HomeScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubit/RegisterCubit/RegisterCubit.dart';
import '../../cubit/RegisterCubit/RegisterStates.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) => Scaffold(
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
                        'Register Screen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'this is Register screen',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          label: Text('name'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
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
                      const SizedBox(
                        height: 20.0,
                      ),
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
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'this field must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_android),
                          label: Text('phone'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 40.0,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                  );
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                                }
                              },
                              child: const Text(
                                'REGISTER NOW',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
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
