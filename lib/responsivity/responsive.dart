

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {

  Widget responsive;
   Responsive({required this.responsive});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context ,BoxConstraints boxConstraints){
      if(boxConstraints.maxWidth>=980){
        print('web');
        return  responsive;
      }else if(boxConstraints.maxWidth>=767){
        print('tablet');
        return  responsive;
      }else{
        print('mobile');
        return  responsive;
      }
    });
  }
}
