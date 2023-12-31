import 'package:chat_app/cubit/HomeCubit/HomeCubit.dart';
import 'package:chat_app/models/PostModel/PostModel.dart';
import 'package:chat_app/modules/feedsScreen/commentScreen/commentScreen.dart';
import 'package:chat_app/styles/my_flutter_app_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../../cubit/HomeCubit/HomeStates.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: HomeCubit.get(context).reFresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: const Card(
                    elevation: 10.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/excited-brunette-chair_23-2147774898.jpg?w=1380&t=st=1688747519~exp=1688748119~hmac=2027095f010036c078f2e6ea42f7c75a6e66ed069fbfc27f4f48c113b24887e0',
                      ),
                      fit: BoxFit.cover,
                      height: 200.0,
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition: HomeCubit.get(context).posts.isNotEmpty,
                  fallback: (context) => const Center(child: CircularProgressIndicator()),
                  builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildPostItem(context, HomeCubit.get(context).posts[index], index),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: HomeCubit.get(context).posts.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
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

  Widget buildPostItem(context, PostModel model, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(height: 1.4, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 22.0,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                maxLines: 4,
                style: const TextStyle(
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              if (model.postImage != '')
                Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            const LikeButton(
                              size: 15.0,
                            ),
                            Text(
                              '${HomeCubit.get(context).likes[index]} Like',
                              style: TextStyle(
                                color: Colors.yellow.shade700,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                      const Spacer(),
                      InkWell(
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 15.0,
                              color: Colors.yellow.shade700,
                            ),
                            const SizedBox(width: 2.0,),
                            Text(
                              '${HomeCubit.get(context).comments[index]} comment',
                              style: TextStyle(color: Colors.yellow.shade700),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16.0,
                        backgroundImage: NetworkImage('${model.image}'),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      const Text(
                        'write a comment...',
                      ),
                      const Spacer(),
                      InkWell(
                        child: const Row(
                          children: [
                            LikeButton(
                              size: 15.0,
                            ),
                            Text(
                              'like',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          HomeCubit.get(context)
                              .likePost(HomeCubit.get(context).postsId[index]);
                        },
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      InkWell(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 15.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              'comment',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen(postId: HomeCubit.get(context).postsId[index],index: index,)));
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
