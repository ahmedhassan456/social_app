
import 'dart:io';

import 'package:chat_app/cubit/HomeCubit/HomeCubit.dart';
import 'package:chat_app/cubit/HomeCubit/HomeStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeCubit.get(context).model;
        var formKey = GlobalKey<FormState>();
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  HomeCubit.get(context).updateUserImages(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                },
                child: const Text(
                  'UPDATE',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
            title: const Text('Edit Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is HomeUpdateUserData)
                      const LinearProgressIndicator(),
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image:coverImage==null? DecorationImage(
                                      image: NetworkImage('${userModel?.coverImage}'),
                                      fit: BoxFit.cover,
                                    ): DecorationImage(
                                      image: FileImage(coverImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                      child: Icon(
                                    Icons.camera_alt_outlined,
                                        size: 16.0,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                                child:profileImage == null?  CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage:NetworkImage('${userModel?.image}'),
                                ) :CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage:FileImage(profileImage),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  HomeCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16.0,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onTap: (){},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Name'),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'this field must not be empty';
                        }
                        return null;
                      },
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onTap: (){},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Bio'),
                        prefixIcon: Icon(Icons.info_outline),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'this field must not be empty';
                        }
                        return null;
                      },
                      controller: bioController,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      onTap: (){},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Phone'),
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'this field must not be empty';
                        }
                        return null;
                      },
                      controller: phoneController,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
