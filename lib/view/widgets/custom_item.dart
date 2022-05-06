
import'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';




class CustomItem extends StatelessWidget {

  String  ?item;
  Callback  ?onTap;
   CustomItem({Key? key , this.item , this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.centerLeft,
      height: 50,
      child: Card(
      //  margin: const EdgeInsets.all(20),
        shadowColor: Colors.purple.shade200,
        elevation: 6,
        color: Colors.purple[300],
        child: InkWell(
          onTap: onTap,
          child: Container(child: Text(item!,) , alignment: Alignment.centerLeft),
        ),
      ),
    );
  }
}
