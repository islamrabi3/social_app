import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/AppCubit/app_cubit.dart';
import 'package:social_app/AppCubit/app_states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).model;
        var postList = AppCubit.get(context).postList;
        return model == null && postList.isEmpty && postList.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://image.freepik.com/free-vector/3d-social-media-icons-background_52683-28863.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildHomeCardItems(
                            model!, context, postList[index]);
                      },
                      itemCount: postList.length,
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget buildHomeCardItems(
      SocialUserModel model, BuildContext context, PostModel postmodel) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    postmodel.userImage!,
                    scale: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postmodel.userName!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        DateTime.now().toString(),
                        style: TextStyle(height: 1.2),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Icon(Icons.menu)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(postmodel.postText!),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: -25.0,
            children: [
              Container(
                height: 20.0,
                child: MaterialButton(
                  height: 2.0,
                  minWidth: 1.0,
                  onPressed: () {},
                  child: Text('#software'),
                ),
              ),
              Container(
                height: 20.0,
                child: MaterialButton(
                  height: 2.0,
                  minWidth: 1.0,
                  onPressed: () {},
                  child: Text('#software'),
                ),
              ),
              Container(
                height: 20.0,
                child: MaterialButton(
                  height: 2.0,
                  minWidth: 1.0,
                  onPressed: () {},
                  child: Text('#software'),
                ),
              ),
              Container(
                height: 20.0,
                child: MaterialButton(
                  height: 2.0,
                  minWidth: 1.0,
                  onPressed: () {},
                  child: Text('#software'),
                ),
              ),
              Container(
                height: 20.0,
                child: MaterialButton(
                  height: 2.0,
                  minWidth: 1.0,
                  onPressed: () {},
                  child: Text('#software-developer'),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Image(
              image: NetworkImage(postmodel.postImageUrl!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.favorite_border_outlined),
                        Text('1')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.comment), Text('1')],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${model.image}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Text('... write a comment !!'),
                      ),
                    ]),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Like'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Share'),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
