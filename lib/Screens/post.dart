import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/AppCubit/app_cubit.dart';
import 'package:social_app/AppCubit/app_states.dart';
import 'package:social_app/layout/layout_screen.dart';
import 'package:social_app/shared/components.dart';

class PostScreen extends StatelessWidget {
  var postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var socialModel = cubit.model;
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    cubit
                        .creatNewPost(pText: postTextController.text)
                        .then((value) {
                      cubit.getPostData();
                      navigateAndRemove(context, SocialLayout());
                      cubit.removePostImageFromPreview();
                    });
                  },
                  child: Text('Add Post'),
                ),
              ),
            ],
            title: Text(
              'New Post ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${socialModel!.image}'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${socialModel.name}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                    onPressed: () {}, child: Text('Public')),
                                SizedBox(
                                  width: 10.0,
                                ),
                                OutlinedButton(
                                    onPressed: () {}, child: Text('Album')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: postTextController,
                    decoration: InputDecoration(
                      hintText: 'Whats in your Mind .....?',
                      helperMaxLines: 100,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              if (cubit.postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250.0,
                      decoration: BoxDecoration(
                        image:
                            DecorationImage(image: FileImage(cubit.postImage!)),
                      ),
                      // color: Colors.amber,
                    ),
                    if (cubit.postImage != null)
                      Container(
                        margin: EdgeInsets.only(
                          right: 20.0,
                        ),
                        child: CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                cubit.removePostImageFromPreview();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        ),
                      ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            cubit.postImagePick(ImageSource.gallery);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.photo),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text('#'),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Tags'),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        );
      },
    );
  }
}
