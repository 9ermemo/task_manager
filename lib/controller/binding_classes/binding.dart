


import 'package:get/get.dart';

import '../note_controller.dart';
import '../user_controller.dart';
import '../util_controller.dart';

class Binding extends  Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<UtilController>(UtilController());
    Get.put<UserController>(UserController());
  // Get.lazyPut(() => NoteController() , fenix: true);
  }

}