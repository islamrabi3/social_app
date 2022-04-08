import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/AppCubit/app_cubit.dart';
import 'package:social_app/AppCubit/app_states.dart';
import 'package:social_app/models/massage.dart';
import 'package:social_app/models/social_user_model.dart';

class ChatUser extends StatelessWidget {
  SocialUserModel? model;

  ChatUser(this.model);

  var massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMassages(receiverId: model!.id!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleSpacing: 0.0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        model!.image!,
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
                            model!.name!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: AppCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var messages =
                                  AppCubit.get(context).messages[index];
                              if (AppCubit.get(context).model!.id ==
                                  messages.senderId)
                                return buildMyMassage(messages);

                              return buildOthersMessage(messages);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: AppCubit.get(context).messages.length),
                      ),
                      // Spacer(),
                      // SizedBox(
                      //   height: 10.0,
                      // ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: massageController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    hintText: 'Type your massage here....!! ',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                height: 50.0,
                                width: 55.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    AppCubit.get(context).sendMessage(
                                        text: massageController.text,
                                        receiverId: model!.id!,
                                        dateTime: DateTime.now().toString());
                                    massageController.text = '';
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  color: Colors.teal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Align buildMyMassage(MassageModel model) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
          color: Colors.teal[300],
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          model.text!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget buildOthersMessage(MassageModel model) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          model.text!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
