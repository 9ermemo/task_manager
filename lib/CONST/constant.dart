


import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Constant{

   static Color? purple = Colors.purple;

   static Color brown = Colors.brown;



  static void showSnackBar(
       String content ,
       BuildContext context
       ) {
      SnackBar snackBar = SnackBar(
         content: Text(content),
         elevation: 5,
         duration: const Duration(seconds: 2),
        action: SnackBarAction(onPressed: () { Get.back(); }, label: 'Cancel',textColor: Colors.purple[200]),

      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
   }

}