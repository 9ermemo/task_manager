import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../CONST/constant.dart';

class CustomButton extends StatelessWidget {
  String title;
  Callback onTap;

  CustomButton({Key? key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 250,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: Constant.brown,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(color: Colors.purple[300], boxShadow: [
          BoxShadow(
            color: Colors.purple.shade700,
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            color: Colors.purple.shade200,
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(-4, -4),
          ),
        ]),
      ),
    );
  }
}
