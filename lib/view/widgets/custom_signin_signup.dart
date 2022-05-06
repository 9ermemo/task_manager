import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../CONST/constant.dart';

class CustomSigninSignUp extends StatelessWidget {
  String title;
  String nextTitle;
  Callback onTap;

  CustomSigninSignUp(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.nextTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15 , color: Constant.brown),
        ),
        const SizedBox(width:10),
        InkWell(child:Text(
          nextTitle,
          style: const TextStyle(color: Colors.blue ,fontSize: 15),
        ),onTap:onTap)
      ],
    );
  }
}
