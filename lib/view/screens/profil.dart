import 'package:flutter/material.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/model/user_model.dart';

import '../../controller/util_controller.dart';
import 'package:get/get.dart';

import '../widgets/custom_dialogh.dart';
import '../widgets/custom_item.dart';
import 'package:get/get.dart';

class Profil extends StatelessWidget {
  Profil({Key? key}) : super(key: key);

  String? fullName, email, password;

  // verify if user data user null or not for updating
  UserModel ISnullOrNot() {
    String? newFullName =
        fullName == null ? _userController.user?.fullName : fullName;
    String? newEmail = email == null ? _userController.user?.email : email;
    String? newPassword =
        password == null ? _userController.user?.password : password;
    String? image = _userController.user?.image;
    int? userId = _userController.user?.userId;
    UserModel user = UserModel(
        userId: userId,
        fullName: newFullName,
        email: newEmail,
        password: newPassword,
        image: image);
    return user;
  }

  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final utilController = Get.find<UtilController>();

    return Scaffold(
      backgroundColor: Colors.purple[300],
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 40),
          GetBuilder<UtilController>(
            builder: (notUsed) {
              return InkWell(
                onTap: () {
                  utilController.getImage();
                },
                // picture
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  child: utilController.image == null
                      ? Image.asset('images/assets/add_picture.png')
                      : Image.file(utilController.image!,
                          height: 150, fit: BoxFit.cover),
                ),
              );
            },
          ),
          //Edit full name
          CustomItem(
            item: '${_userController.user?.fullName}',
            onTap: () {

              showCustomDialog(
                submit: () async {
                   UserModel user = ISnullOrNot();
             int fullNameUpdated =   await  _userController.updateAccount(user: user);
             print(fullNameUpdated);
                },
                title: const Text('Full Name'),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Edite Full Name',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                     fullName = value;
                    }),
                context: context,
              );
            },
          ),
          // Edite Email
          CustomItem(
            item: '${_userController.user?.email}',
            onTap: () {
              showCustomDialog(
                submit: () async {
                  UserModel user = ISnullOrNot();
                  int emailUpdated =   await  _userController.updateAccount(user: user);
                  print(emailUpdated);
                },
                title: const Text('Email'),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Edite Email', border: OutlineInputBorder()),
                    onChanged: (value) {
                     email = value;
                    }),
                context: context,
              );
            },
          ),
          //Edite password
          CustomItem(
            item: '***${_userController.user?.password?.substring(2)}',
            onTap: () {

              showCustomDialog(
                submit: () async {
                  UserModel user = ISnullOrNot();
                  int passwordUpdated =   await  _userController.updateAccount(user: user);
                  print(passwordUpdated);
                },
                title: const Text('Password'),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Edite Password',
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                       password = value;
                    }),
                context: context,
              );
            },
          ),

          // specie case need to change shared pref and into database
          CustomItem(
            item: 'Deconnexion',
            onTap: () {
              print(' go to deconnexion ');
            },
          ),
          // specie case need changement  into database
          CustomItem(
            item: 'Delete Account',
            onTap: () async {
              UserModel user = ISnullOrNot();
           int accountDeleted =   await _userController.deleteAccount(user: user);
           print(accountDeleted);
            },
          ),
        ],
      ),
    );
  }
}
