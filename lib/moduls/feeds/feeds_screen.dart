import 'package:chat_app/styles/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context , index) => buildPostItem(context),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context,index) => const SizedBox(height: 10.0,),
          ),
        ],
      ),
    );
  }
  Widget buildPostItem(context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    elevation: 10.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('https://img.freepik.com/free-photo/beautiful-smiling-model-with-afro-curls-hairstyle-dressed-summer-hipster-white-dress_158538-708.jpg?w=996&t=st=1688748782~exp=1688749382~hmac=23a08b3b7cf7a4315a5e83b3b8709eb7387d1781e88024c2dd71fe40256ea793'),

              ),
              const SizedBox(width: 15.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Ahmed Hassan',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        SizedBox(width: 4.0,),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        )
                      ],
                    ),
                    Text(
                      'January 21, 2023 at 11:00 pm',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz,size: 22.0,))
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
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
            style: TextStyle(
              height: 1.3,
            ),
          ),
          Container(
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image: const DecorationImage(
                image: NetworkImage('https://img.freepik.com/free-photo/happy-positive-pretty-young-woman-with-curly-hair-red-blouse-laughing-silly-carefree-as-gazing-pleased-upper-left-corner-touching-face-satisfied-delighted-yellow-wall_1258-81988.jpg?w=1060&t=st=1688750596~exp=1688751196~hmac=759fb8ddaffb1ea413edf3e35862ab26cbb239611b77f10143f232c08669ad81'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    child: const Icon(Icons.heart_broken_outlined, size: 15.0,),
                    onTap: (){},
                  ),
                  const Text(
                    '2000',
                  ),
                  const Spacer(),
                  InkWell(
                    child: Icon(Icons.comment_outlined, size: 15.0,color: Colors.yellow.shade700,),
                    onTap: (){},
                  ),
                  Text('2000 comment',style: TextStyle(color: Colors.yellow.shade700),),
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
                  const CircleAvatar(
                    radius: 16.0,
                    backgroundImage: NetworkImage('https://img.freepik.com/free-photo/beautiful-smiling-model-with-afro-curls-hairstyle-dressed-summer-hipster-white-dress_158538-708.jpg?w=996&t=st=1688748782~exp=1688749382~hmac=23a08b3b7cf7a4315a5e83b3b8709eb7387d1781e88024c2dd71fe40256ea793'),

                  ),
                  const SizedBox(width: 15.0,),
                  const Text(
                    'write a comment...',
                  ),
                  const Spacer(),
                  InkWell(
                    child: const Icon(Icons.heart_broken_outlined, size: 15.0,),
                    onTap: (){},
                  ),
                  const Text(
                    'like',
                  ),
                  const SizedBox(width: 15.0,),
                  InkWell(
                    child: const Icon(Icons.comment_outlined, size: 15.0),
                    onTap: (){},
                  ),
                  const Text('comment',),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
