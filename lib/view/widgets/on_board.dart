

import 'package:flutter/material.dart';


class OnBoard extends StatelessWidget {

  Widget child ;
  int flex;

   OnBoard({Key? key, required this.child , required this.flex }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: child ,flex: flex,);
  }
}
