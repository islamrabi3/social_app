import 'package:flutter/material.dart';
import 'package:social_app/Screens/authScreens/loginScreen/login.dart';
import 'package:social_app/Screens/authScreens/registerCubit/register_cubit.dart';
import 'package:social_app/Screens/authScreens/registerCubit/register_states.dart';
import 'package:social_app/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegsiterSates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[100],
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register Now !',
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
                      dTextFormField(
                        controller: phoneController,
                        textinput: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Check your Phone Number !';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Icons.phone,
                        label: 'Phone',
                        hintText: 'Write Your Phone Number here !',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      dTextFormField(
                        controller: nameController,
                        textinput: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Check your Name Field !';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Icons.person,
                        label: 'Name',
                        hintText: 'Write Your Username here !',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // if (state is RegisterLoadingState)
                      //   CircularProgressIndicator(),
                      state is RegisterLoadingState
                          ? Center(child: CircularProgressIndicator())
                          : defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).createUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                  navigatetTo(context, LoginScreen());
                                } else {
                                  print('There is An Error !!');
                                }
                              },
                              text: 'REGISTER NOW !'),

                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () => navigatetTo(context, LoginScreen()),
                        text: "LOGIN",
                      ),
                    ],
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
