import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/AppCubit/app_states.dart';
import 'package:social_app/Screens/chatScreen/chat_screen.dart';
import 'package:social_app/Screens/homeScreen/home_screen.dart';
import 'package:social_app/Screens/pofileScreen/profile_screen.dart';
import 'package:social_app/Screens/postScreen/add_postScreen.dart';
import 'package:social_app/Screens/setting/setting.dart';
import 'package:social_app/Screens/post.dart';
import 'package:social_app/dio/dio_helper.dart';
import 'package:social_app/models/massage.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/shared/const.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> title = [
    'New Feeds',
    'Chat',
    'Add New Post',
    'Profile',
    'Settings'
  ];

  List<Widget> screen = [
    HomeScreen(),
    ChatScreen(),
    NewPostScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(index, context) {
    if (index == 0) {
      getUserData();
      getPostData();
    }
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      return navigatetTo(context, PostScreen());
    }
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  SocialUserModel? model;
  void getUserData() {
    emit(AppLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialUserModel.fromJson(value.data()!);
      print(model!.bio);
      emit(AppSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorState());
    });
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();
  String? profileImageUrl;
  String? coverImageUrl;
  void pickProfileImage(ImageSource src) async {
    var profImage = await picker.pickImage(source: src);
    if (profImage != null) {
      profileImage = File(profImage.path);

      // put file in Firebase Storage
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          profileImageUrl = value;
        });
        emit(ProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ProfileImageErrorState());
      });
    } else {
      print('No Image Picked');
    }
  }

  File? coverImage;
  void pickCoverImage(ImageSource src) async {
    var covImage = await picker.pickImage(source: src);
    if (covImage != null) {
      coverImage = File(covImage.path);
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Uri.file(coverImage!.path).pathSegments.last}')
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          coverImageUrl = value;
        });
        print(coverImageUrl);
        emit(CoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(CoverImageErrorState());
      });
    } else {
      print('No Cover Image picked');
    }
  }

  Future<void> updateProfileData({
    String? cover,
    String? image,
    required String bio,
    required String name,
    required String phone,
    String? email,
    String? password,
    String? date,
    String? id,
  }) async {
    emit(UpdateProfileLoading());
    model = SocialUserModel(
      name: name,
      password: password ?? model!.password,
      email: email ?? model!.email,
      phone: phone,
      cover: coverImageUrl ?? model!.cover,
      image: profileImageUrl ?? model!.image,
      date: date ?? model!.date,
      isConfirmed: model!.isConfirmed,
      id: id ?? model!.id,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model!.toMap())
        .then((value) {
      getUserData();

      emit(UpdateProfileSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateProfileError());
    });
  }

  File? postImage;
  void postImagePick(ImageSource src) async {
    var picker_1 = ImagePicker();
    var pickedPostImage = await picker_1.pickImage(source: src);
    if (pickedPostImage != null) {
      postImage = File(pickedPostImage.path);

      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          postImageUrl = value;
        }).catchError((error) {
          print(error.toString());
        });
      });
      emit(PostImagePickedSuccess());
    } else {
      print("no Image Picked");
      emit(PostImagePickedError());
    }
  }

  void removePostImageFromPreview() {
    postImage = null;
    emit(RemovePostImageFromPreviewState());
  }

  String? postImageUrl;

  // w
  PostModel? postModel;

  Future<void> creatNewPost({required String pText}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('posts')
        .doc()
        .get()
        .then((value) async {
      postId = value.id;
      postModel = PostModel(
        postText: pText,
        postImageUrl: postImageUrl ?? '',
        postTime: DateTime.now().toString(),
        userImage: model!.image,
        userName: model!.name,
        postId: postId,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('posts')
          .doc(postId)
          .set(postModel!.toMap())
          .then((value) {
        print('post Created');
        emit(CreatNewPostSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(CreatNewPostError());
      });
    });
  }

  List<PostModel> postList = [];
  void getPostData() {
    postList = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('posts')
        .orderBy('postTime', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        postList.add(
          PostModel.fromJson(element.data()),
        );
      });
      print(postList[0].userName);
      print(postList[0].postImageUrl);
      emit(GetPostDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetPostDataError());
    });
  }

  List<SocialUserModel> users = [];
  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['id'] != model!.id)
            users.add(
              SocialUserModel.fromJson(element.data()),
            );
        });
        emit(GetAllUsersSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUsersError());
      });
  }

  // Send Massage From Me To others Collection

  Future<void> sendMessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) async {
    MassageModel massageModel = MassageModel(
      dateTime: dateTime,
      receiverId: receiverId,
      text: text,
      senderId: model!.id,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(model!.id)
        .collection('chats')
        .doc(receiverId)
        .collection('massages')
        .add(massageModel.toMap())
        .then((value) {
      emit(SendMassageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMassageSError());
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.id)
        .collection('massages')
        .add(massageModel.toMap())
        .then((value) {
      emit(SendMassageSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMassageSError());
    });
  }

  List<MassageModel> messages = [];
  void getMassages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.id)
        .collection('chats')
        .doc(receiverId)
        .collection('massages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MassageModel.fromJson(element.data()));
      });
      emit(GetMassageSuccess());
    });
  }
}
