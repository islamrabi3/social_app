import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Screens/authScreens/registerCubit/register_states.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCubit extends Cubit<RegsiterSates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel? model;

  String? docId;
  void createUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? date,
  }) async {
    emit(RegisterLoadingState());
    var auth = FirebaseAuth.instance;

    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      model = UserModel(
          name: name,
          password: password,
          email: email,
          phone: phone,
          date: DateTime.now().toString(),
          id: value.user!.uid,
          isConfirmed: true,
          cover:
              'https://image.freepik.com/free-vector/halloween-background-flat-design_52683-43845.jpg',
          image:
              'https://image.freepik.com/free-vector/halloween-background-flat-design_52683-43845.jpg',
          bio: 'write SomeThing about yourself');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(model!.toMap());

      // CacheHelper.saveData(key: 'uId', value: value.user!.uid);

      print(value.user!.uid);

      // var docData = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(value.user!.uid)
      //     .get();
      // model = UserModel.fromJson(docData.data()!);

      // print(model!.phone);

      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }
}
