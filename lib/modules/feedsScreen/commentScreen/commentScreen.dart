import 'package:chat_app/cubit/HomeCubit/HomeCubit.dart';
import 'package:chat_app/cubit/HomeCubit/HomeStates.dart';
import 'package:chat_app/models/commentModel/CommentModel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {
  final String postId;
  final int index;
  const CommentScreen({super.key,required this.postId,required this.index});

  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeSetCommentPostSuccessState){
          HomeCubit.get(context).getCommentsData();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(
              'Comments',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    condition: HomeCubit.get(context).commentsData.isNotEmpty,
                    builder:(context) => ListView.separated(
                      itemBuilder: (context, idx) => buildCommentItem(HomeCubit.get(context).commentsData[index],context),
                      separatorBuilder:(context, idx) => const SizedBox(height: 10.0,),
                      itemCount: HomeCubit.get(context).comments[index],
                    ),
                    fallback: (context) => const Center(child: CircularProgressIndicator()),
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
                            controller: commentController,
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
                              HomeCubit.get(context).setCommentData(
                                  postId: postId,
                                  dateTime: DateTime.now().toString(),
                                  text: commentController.text,
                              );
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
        );
      },
    );
  }

  Widget buildCommentItem(CommentModel cModel,context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage('${cModel.image}'),
          ),
          const SizedBox(width: 5.0,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.blue.shade300,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Column(
              children: [
                Text(
                  '${cModel.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  '${cModel.text}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
