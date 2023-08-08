import 'package:chat_app/cubit/HomeCubit/HomeCubit.dart';
import 'package:chat_app/models/MessageModel/MessageModel.dart';
import 'package:chat_app/models/userModel/userModel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/HomeCubit/HomeStates.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? model;
  ChatDetailsScreen({super.key,required this.model});
  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(
      builder: (context) {
        if(HomeCubit.get(context).messages.isEmpty){
          HomeCubit.get(context).getMessages(receiverId: model!.uId.toString());
        }
        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${model?.image}'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${model?.name}',
                      style: const TextStyle(
                        height: 1.4,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25.0,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              body: ConditionalBuilder(
                condition: HomeCubit.get(context).messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = HomeCubit.get(context).messages[index];
                              if(HomeCubit.get(context).model?.uId == message.senderId){
                                return buildMyMessage(message);
                              }
                              return buildMessage(message);
                            },
                            separatorBuilder: (context,index) => const SizedBox(height: 15.0,),
                            itemCount: HomeCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color:Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here...',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  controller: messageController,
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.blue.shade300,
                                ),
                                child: IconButton(
                                  onPressed: (){
                                    HomeCubit.get(context).sendMessage(
                                      receiverId: model!.uId.toString(),
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );

                                    HomeCubit.get(context).getMessages(receiverId: model!.uId.toString());
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildMessage(MessageModel mModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        color: Colors.blue.shade300,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        '${mModel.text}',
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
    ),
  );
  Widget buildMyMessage(MessageModel mModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        color: Colors.blue.shade300,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        '${mModel.text}',
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
    ),
  );
}
