import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/model/user_model.dart';
import 'package:task_manager/view/screens/signin.dart';
import '../../CONST/constant.dart';
import '../../controller/util_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_signin_signup.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  GlobalKey<FormState> form = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? password;
  String? secondPassword;
  UserModel? user;

  final utilController = Get.find<UtilController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.purple[300],
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 40),
        children: [
          // welcome title
          Text("Welcome Onboard!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Constant.brown),
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          // sub welcome title
          Text("let's help you meet up your tasks.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Constant.brown)),
          // texts field
          GetBuilder<UtilController>(
            builder: (_) {
              return InkWell(
                  onTap: () {
                    utilController.getImage();
                  },
                  // picture
                  child: Container(
                    child: utilController.image == null
                        ? Image.asset('images/assets/add_picture.png')
                        : Image.file(
                            utilController.image!,
                            width: 50,
                            height: 50,
                          ),
                    height: 50,
                    width: 50,
                  ));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // field for FullName
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your full name',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide.none),
                    ),
                    cursorColor: Colors.purple,
                    onChanged: (fullName) {
                      this.fullName = fullName.trim();
                    },
                    validator: (fullNameV) {
                      if (fullNameV!.isEmpty) {
                        return 'Is Empty';
                      }
                      if (fullNameV.length < 5) {
                        return "Must 8 characters ";
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  // field for Email
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
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
                  // Register Button ... we need some logic here for registration ...
                  GetBuilder<UserController>(
                    builder: (notUsed) {
                      return CustomButton(
                        title: 'Register',
                        onTap: () async {
                          if (form.currentState!.validate()) {
                            user =UserModel(email: email ,fullName: fullName , password: password,image: utilController.image?.path);
                             int rowInserted = await  UserController(user: user).signUp();
                             print(rowInserted);
                            Constant.showSnackBar('Successful', context);
                             Get.off(()=>Signing(),
                               transition:Transition.zoom,
                               duration:const Duration(seconds:1)
                             );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // already have account expression...or not ?
                  CustomSigninSignUp(
                    onTap: () {
                      Get.off(() => Signing());
                    },
                    title: 'Already have an account ?',
                    nextTitle: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
