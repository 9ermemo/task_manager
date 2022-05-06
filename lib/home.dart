import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/view/screens/signin.dart';
import 'package:task_manager/view/screens/signup.dart';
import 'package:task_manager/view/widgets/custom_signin_signup.dart';
import 'package:task_manager/view/widgets/on_board.dart';
import 'CONST/constant.dart';
import 'package:get/get.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[300],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            // main title in onboard
            OnBoard(
                child: Text(
                  'Mange all\nyour Daily \nTask with\nSimplicity',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Constant.brown),
                ),
                flex: 2),
            // main image in onboard
            OnBoard(
              child: Image.asset('images/assets/onboard.png', width: 500),
              flex: 2,
            ),
            // button on onboard... has Signup & Signing buttons
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // Signup
                    Container(
                        child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            elevation: 3,
                            primary: Colors.purple[300],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          ) ,
                            onPressed: () {
                              Get.off( ()=>Signup()  ,transition: Transition.cupertino,duration: Duration(seconds: 1)  );
                            },
                            child: Text(
                              'Create new account',
                              style: TextStyle(
                                  color: Constant.brown, fontSize: 20),
                            )),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 35)),

                  const  SizedBox(height: 15),

                    // Login
                    CustomSigninSignUp(title: 'Already have an account? ',
                        onTap: ()=>Get.off( ()=>Signing()  ,transition: Transition.cupertino, duration: Duration(seconds: 1) ),
                        nextTitle: 'Login',)
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
