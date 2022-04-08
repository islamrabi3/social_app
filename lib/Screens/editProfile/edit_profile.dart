import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/AppCubit/app_cubit.dart';
import 'package:social_app/AppCubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var model = cubit.model;
        // var coverImageUrl = cubit.coverImageUrl;
        // var profileImageUrl = cubit.profileImageUrl;

        bioController.text = model!.bio!;
        nameController.text = model.name!;
        phoneController.text = model.phone!;
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    cubit
                        .updateProfileData(
                            bio: bioController.text,
                            name: nameController.text,
                            phone: phoneController.text)
                        .then((value) {
                      cubit.getUserData();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text('UpDate'),
                ),
              ),
            ],
            title: Text(
              'Edit Your Profile',
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            if (cubit.coverImage != null)
                              Container(
                                width: double.infinity,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(cubit.coverImage!),
                                  ),
                                ),
                              ),
                            if (cubit.coverImage == null)
                              Container(
                                width: double.infinity,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('${model.cover}'),
                                  ),
                                ),
                              ),
                            InkWell(
                              onTap: () {
                                cubit.pickCoverImage(ImageSource.gallery);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.add_a_photo),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 65.0,
                            child: cubit.profileImage != null
                                ? CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage:
                                        FileImage(cubit.profileImage!),
                                  )
                                : CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(model.image!),
                                  ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.pickProfileImage(ImageSource.gallery);
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.add_a_photo),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: bioController,
                    // initialValue: "My name is islam",
                    keyboardType: TextInputType.text,
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Write your Bio',
                      labelText: 'Bio',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: nameController,
                    // initialValue: "My name is islam",
                    keyboardType: TextInputType.text,
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Write your Name',
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: phoneController,
                    // initialValue: "My name is islam",
                    keyboardType: TextInputType.phone,
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Write your Phone',
                      labelText: 'Phone',
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
}
