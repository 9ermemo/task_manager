import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager/responsivity/responsive.dart';
import 'package:task_manager/view/screens/bottom_navigator.dart';
import 'controller/binding_classes/binding.dart';
import 'controller/user_controller.dart';
import 'home.dart';
import 'package:get/get.dart';

void main()  {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //final userController = Get.find<UserController>();



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Responsive(responsive: UserController().getSharedValue() == true? BottomNavigator() : const Home()) ,
    );
  }
}


