import 'package:chat_app/cubit/HomeCubit/HomeCubit.dart';
import 'package:chat_app/cubit/HomeCubit/HomeStates.dart';
import 'package:chat_app/modules/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    var now = DateTime.now();
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Create Post',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    if(HomeCubit.get(context).postImage == null){
                      HomeCubit.get(context).createNewPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }else{
                      HomeCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }
                  },
                  child: const Text('POST',style: TextStyle(fontSize: 20.0),
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is HomeLoadingCreatePostState)
                  const LinearProgressIndicator(),
                if(state is HomeLoadingCreatePostState)
                  const SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${HomeCubit.get(context).model?.image}'),

                    ),
                    const SizedBox(width: 15.0,),
                    Text(
                      '${HomeCubit.get(context).model?.name}',
                      style: const TextStyle(
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4.0,),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 16.0,
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'What is in your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(HomeCubit.get(context).postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 140.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(HomeCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                        HomeCubit.get(context).removePostImage();
                      }, icon: const Icon(Icons.close)),
                    ],
                  ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            HomeCubit.get(context).getPostImage();
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.image),
                              SizedBox(width: 4.0,),
                              Text('Add Photo'),
                            ],
                          )
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: const Text('# tags',style: TextStyle(fontSize: 16.0),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
