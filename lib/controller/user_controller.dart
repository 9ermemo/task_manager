import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/model/user_model.dart';
import 'package:task_manager/services/user_services.dart';

class UserController extends GetxController{

  bool isLoading=true;
  File ? image;
  UserController({this.user});
  UserModel? user;

  UserModel? get users => user ;
  setUser(UserModel? user){
    this.user = user;
  }

  getImage() async {
    isLoading=true;
    var picker = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    if (picker != null) {
      image = File(picker.path);
      update();
      isLoading=false;
    }
  }
  // update image only
  Future<int> updateImage({UserModel? user}) async {
    int isUpdated =  await  UserServices().updateImage(user: user);
    update();
    return isUpdated;
  }

  // get user information

  Future<void> getUser() async{
    isLoading=true;
    List data = await UserServices().getUser(user: user);
    data.map((userItem){
      user = UserModel.fromJson(userItem);
    });
    isLoading=false;
    update();
  }

// signUp
 Future<int> signUp()async {
   isLoading=true;
   int inserted = await  UserServices().signUp(user: user);
   isLoading=false;
   return inserted;
  }

// signIn

  Future signIn({UserModel ?user })async {
    isLoading=true;
   dynamic isLogin = await UserServices().signIn(user: user);
   isLoading=false;
   return isLogin;
  }

// delete Account
  Future<int> deleteAccount({UserModel? user}) async {
    isLoading=true;
    int isDeleted = await UserServices().deleteAccount(user: user);
    isLoading=false;
    getUser();
    return isDeleted;
}

// update Account
  Future<int> updateAccount({ UserModel? user}) async {
    isLoading=true;
    int isUpdated = await UserServices().updateAccount(user: user);
    isLoading=false;
    getUser();
    return isUpdated;
  }

// logOut
  logOut({ UserModel? user})  {
    // build a 'sharedPreferences' here
    // back to onBoarding
  }



}