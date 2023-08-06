import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/HomeCubit/HomeCubit.dart';
import '../../cubit/HomeCubit/HomeStates.dart';
import '../../models/userModel/userModel.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).usersI.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildUserItem(HomeCubit.get(context).usersI[index],context),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              height: 1.0,
            ),
            itemCount: HomeCubit.get(context).usersI.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildUserItem(UserModel model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage('${model.image}'),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          '${model.name}',
          style: const TextStyle(
            height: 1.4,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );

}