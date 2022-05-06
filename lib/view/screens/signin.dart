import 'package:flutter/material.dart';
import 'package:task_manager/model/user_model.dart';
import 'package:task_manager/view/screens/signup.dart';
import '../../CONST/constant.dart';
import '../../controller/user_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_signin_signup.dart';
import 'package:get/get.dart';
import 'bottom_navigator.dart';

class Signing extends StatelessWidget {
  Signing({Key? key}) : super(key: key);

  GlobalKey<FormState> form = GlobalKey<FormState>();
  String? email;
  String? password;
  UserModel? user;
  final UserController userController = Get.find<UserController>();

  // final  NoteController noteController = Get.put(NoteController());
  // final  UserController userController = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: form,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 40),
              // an Title her
              Text("Welcome Back!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Constant.brown),
                  textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Image.asset('images/assets/login.png', height: 200),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none),
                ),
                cursorColor: Colors.purple,
                onChanged: (email) {
                  this.email = email.trim();
                },
                validator: (emailV) {
                  if (emailV!.isEmpty) {
                    return 'Is Empty';
                  }
                  if (emailV.length < 5) {
                    return "Must 8 characters ";
                  }
                },
              ),
              const SizedBox(height: 20),
              // field for Password
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none),
                ),
                cursorColor: Colors.purple,
                onChanged: (password) {
                  this.password = password.trim();
                },
                validator: (passwordV) {
                  if (passwordV!.isEmpty) {
                    return 'Is Empty';
                  }
                  if (passwordV.length < 5) {
                    return "Must 8 characters ";
                  }
                },
              ),
              const SizedBox(height: 20),
              // Login Button ... we need some logic here for Signing ...
              CustomButton(
                title: 'Login',
                onTap: () async {
                  if (form.currentState!.validate()) {
                    user = UserModel(email: email, password: password);
                    dynamic data = await userController.signIn(user: user);
                    if (data == -1) {
                      Constant.showSnackBar( 'email & password are incorrect',context);
                      return;
                    }
                    if (data == -2) {
                      Constant.showSnackBar( 'email is incorrect',context);
                      return;
                    }
                    if (data == -3) {
                      Constant.showSnackBar( '  password is incorrect',context);
                      return;
                    } else {
                      user = data[0];
                      userController.setUser(user);
                      // 'go to dashboard' and pass userId as an argument
                      Constant.showSnackBar('Welcome back !',context);
                      Get.off(
                        () => BottomNavigator(user: user),
                        transition: Transition.zoom,
                        duration: const Duration(seconds: 1),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              // already have account expression...or not ?
              CustomSigninSignUp(
                onTap: () {
                  Get.off(() => Signup());
                },
                title: 'Already have an account ?',
                nextTitle: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }

}
