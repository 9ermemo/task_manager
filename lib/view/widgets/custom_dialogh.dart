import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../controller/util_controller.dart';
import'package:get/get.dart';


 showCustomDialog(
    {required Widget title,
         required Widget child,
      required Callback submit,
      required BuildContext context})
async {

  await showCupertinoDialog(context: context,barrierDismissible: true,barrierLabel:'barrierLabel', builder: (context){
    final utilController = Get.find<UtilController>();

    return Scaffold(
       backgroundColor: Colors.purple[300],
      appBar: AppBar(elevation: 0 ,backgroundColor: Colors.transparent ,iconTheme: IconThemeData(color: Colors.black54)),
      body: CupertinoAlertDialog(
        title: title,
        content: Column(
            children: [
              child,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: submit, child: Text('Submit')),
                  TextButton(onPressed: (){Navigator.pop(context);},
                    child: Text('cancel',style: TextStyle(color: Colors.redAccent)),)
                ],
              ),
            ],
          ),
      ),
    );
  }
  );}

