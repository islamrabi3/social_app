import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Screens/authScreens/loginCubit/login_states.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/shared/cacheHelper/cache_helper.dart';

class LoginCubit extends Cubit<LoginSates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> userSignIn(String email, String password) async {
    emit(LoginLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      print(value.user!.uid);
    });
    emit(LoginSuccessState());
  }

  // void signOut() {
  //   CacheHelper.removeData(key: 'uId');
  //   emit(SignoutSuccessState());
  // }
}
