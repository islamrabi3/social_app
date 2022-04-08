import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Screens/authScreens/loginCubit/login_cubit.dart';
import 'package:social_app/Screens/authScreens/loginCubit/login_states.dart';
import 'package:social_app/Screens/authScreens/registerScreen/register.dart';
import 'package:social_app/layout/layout_screen.dart';
import 'package:social_app/shared/components.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginSates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.grey[100],
              elevation: 0.0,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN NOW !',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('We with you great Communicate with others'),
                        SizedBox(
                          height: 20.0,
                        ),
                        dTextFormField(
                          controller: emailController,
                          textinput: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please Check your Email !';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.email,
                          label: 'Email Address',
                          hintText: 'Write Your Email here !',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        dTextFormField(
                          controller: passwordController,
                          textinput: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password is too Weak';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.lock,
                          label: 'Password ',
                          hintText: 'Write Your Password here !',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        // if (state is RegisterLoadingState)
                        //   CircularProgressIndicator(),
                        state is LoginLoadingState || state is LoginErrorState
                            ? Center(child: CircularProgressIndicator())
                            : defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context)
                                        .userSignIn(
                                          emailController.text,
                                          passwordController.text,
                                        )
                                        .then((value) => navigateAndRemove(
                                            context, SocialLayout()));
                                  } else {
                                    print('There is An Error !!');
                                  }
                                },
                                text: 'LOGIN NOW !'),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultButton(
                            function: () {
                              navigateAndRemove(context, RegisterScreen());
                            },
                            text: 'REGISTER NOW')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
