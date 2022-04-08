import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:social_app/AppCubit/app_cubit.dart';
import 'package:social_app/Screens/authScreens/registerScreen/register.dart';
import 'package:bloc/bloc.dart';
import 'package:social_app/dio/dio_helper.dart';
import 'package:social_app/layout/layout_screen.dart';
import 'package:social_app/shared/cacheHelper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/const.dart';

import 'blocObserver/bloc_observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message opened onBackground');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // DioHelper.init();

  await CacheHelper.init();

  // String? uId = CacheHelper.sharedPreferences!.getString('uId');
  uId = CacheHelper.sharedPreferences?.getString('uId');

  Widget widget;

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = RegisterScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getUserData()
              ..getPostData()
              ..getAllUsers())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social App',
        theme: ThemeData(
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
          primaryColor: Colors.blue,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Colors.grey[500],
              fontSize: 15.0,
            ),
          ),
          // backgroundColor: Colors.white,
          // accentColor: Colors.blue,
          // colorScheme: ColorScheme(
          //   primary:  Colors.blue,
          //   primaryVariant: primaryVariant,
          //   secondary: secondary,
          //   secondaryVariant: secondaryVariant,
          //   surface: surface,
          //   background: background,
          //   error: error,
          //   onPrimary: onPrimary,
          //   onSecondary: onSecondary,
          //   onSurface: onSurface,
          //   onBackground: onBackground,
          //   onError: onError,
          //   brightness: brightness,
          // ),
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            // color: Colors.white,
            elevation: 0.0,

            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          primarySwatch: Colors.blue,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 10.0,
            showSelectedLabels: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
          ),
        ),
        home: startWidget,
      ),
    );
  }
}
