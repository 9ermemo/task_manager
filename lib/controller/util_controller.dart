import 'dart:io';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/model/user_model.dart';

// this class for unspecific widgets
class UtilController extends GetxController {
  UserController ? userController;
// variable for flowing between screens
  int selector = 0;

// variable for set a value into slider
  double start = 0;

// variable for set a value into dropdown
  var level  ;

  var category  ;



// function for BottomNavigationBar
  int selectScreen(int value) {
    // pass i value to selector variable
    selector = value;
    update();
    return selector;
  }

// function for Slider
  selectValue(double value) {
    start = value;
    print(start.toInt());
    update();
  }

  File ? image;
  getImage() async {
    var picker = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    if (picker != null) {
      image = File(picker.path);
      update();
    }
  }

// function for dropdown for levels ( h , m , e)
      selectLevel(value){
        level = value;
        print(level);
        update();
      }


  // function for dropdown for Categories...
    selectCategory(value){
      category = value;
      print(category);
      update();
  }



}
