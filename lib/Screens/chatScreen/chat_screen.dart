import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/AppCubit/app_cubit.dart';
import 'package:social_app/AppCubit/app_states.dart';
import 'package:social_app/Screens/chatScreen/chat_user.dart';
import 'package:social_app/models/social_user_model.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:social_app/shared/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildChatTile(context, AppCubit.get(context).users[index]),
            separatorBuilder: (context, index) => SizedBox(
              height: 5.0,
            ),
            itemCount: AppCubit.get(context).users.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildChatTile(context, SocialUserModel model) => InkWell(
        onTap: () {
          navigatetTo(context, ChatUser(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    model.image!,
                    scale: 1.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
