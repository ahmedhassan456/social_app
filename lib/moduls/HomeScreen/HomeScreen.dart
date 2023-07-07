import 'package:chat_app/cubit/HomeCubit/HomeCubit.dart';
import 'package:chat_app/cubit/HomeCubit/HomeStates.dart';
import 'package:chat_app/moduls/New_Post/NewPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state){
        if(state is HomeNewPost){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPostScreen()));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            cubit.titles[cubit.currentIndex],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25.0,
            ),
          ),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active_outlined)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
            BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'Chat',),
            BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Post',),
            BottomNavigationBarItem(icon: Icon(Icons.location_city), label: 'Users',),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings',),
          ],
          onTap: (index){
            cubit.changeNavBar(index: index);
          },
          currentIndex: cubit.currentIndex,
        ),
      ),
    );
  }
}
