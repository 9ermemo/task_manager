import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/note_controller.dart';
import 'package:task_manager/model/note_model.dart';
import 'package:task_manager/model/user_model.dart';
import 'package:task_manager/services/note_services.dart';
import 'package:task_manager/view/screens/home_page.dart';
import 'package:task_manager/view/screens/profil.dart';
import 'package:task_manager/view/screens/projects.dart';
import 'package:task_manager/view/widgets/custom_button.dart';

import '../../CONST/constant.dart';
import '../../controller/util_controller.dart';

class BottomNavigator extends StatelessWidget {
  UserModel? user;

  BottomNavigator({this.user});

  // List of widgets  for bottomNavigatorBar
  List<Widget> pages = [HomePage(), Projects(), Profil()];
  List<String> levels = ['High', 'Medium', 'Easy'];
  List<String> categories = ['Home', 'Sport', 'Work', 'Family', 'Shopping', 'Health', 'Personal'];

  //global key
  GlobalKey<FormState> form = GlobalKey<FormState>();

//  slider variables
  double min = 0;
  double max = 100;

// note object variables
  String? title;
  String? description;
  bool isDone = false;
  NoteModel? note;


  final UtilController utilController = Get.find<UtilController>();
  final NoteController noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<UtilController>(
      builder: (_) {
        return Scaffold(
          // floating Action Button for adding notes
          floatingActionButton: Container(
            margin: EdgeInsets.only(left: 25),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
                backgroundColor: Colors.purple.shade500.withOpacity(0.2),
                elevation: 20,
                onPressed: () {
                  showModalBottomSheet(
                      //isScrollControlled: true,
                      context: Get.overlayContext!,
                      builder: (BuildContext context) {
                        return GetBuilder<UtilController>(
                          builder: (_) {
                            return Column(
                              children: [
                                const SizedBox(height: 5),
                                //Title & Description for textFiled
                                Form(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    child: Column(
                                      children: [
                                        // note title
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter task Title',
                                            focusColor: Colors.purple.shade300,
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          cursorColor: Colors.purple,
                                          onChanged: (title) {
                                            this.title = title;
                                          },
                                          validator: (titleV) {
                                            if (titleV!.isEmpty) {
                                              return 'Is Empty';
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 7),
                                        // note description
                                        TextFormField(
                                          maxLines: 2,
                                          decoration: InputDecoration(
                                            hintText: 'Enter task Description',
                                            focusColor: Colors.purple.shade300,
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          cursorColor: Colors.purple,
                                          onChanged: (description) {
                                            this.description = description;
                                          },
                                          validator: (descriptionV) {
                                            if (descriptionV!.isEmpty) {
                                              return 'Is Empty';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Slider
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Row(
                                    children: [
                                      const Text('Set Percentage'),
                                      const SizedBox(width: 20),
                                      Slider(
                                        thumbColor: Colors.purple[300],
                                        divisions: 10,
                                        mouseCursor: MouseCursor.defer,
                                        label: utilController.start.toString(),
                                        value: utilController.start,
                                        min: min,
                                        max: max,
                                        onChanged: utilController.selectValue,
                                      ),
                                    ],
                                  ),
                                ),
                                // dropDown for level
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Row(
                                    children: [
                                      const Text('Set Level of task'),
                                      const SizedBox(width: 20),
                                      DropdownButton(
                                        items: levels.map((level) {
                                          return DropdownMenuItem(
                                              value: level, child: Text(level));
                                        }).toList(),
                                        onChanged: utilController.selectLevel,
                                        value: utilController.level ?? 'High',
                                        elevation: 10,
                                        dropdownColor: Colors.purple[300],
                                        style: TextStyle(color: Colors.white),
                                        iconSize: 50,
                                        iconEnabledColor: Colors.purple[300],
                                      ),
                                    ],
                                  ),
                                ),
                                // dropDown for category
                                Padding(
                                  key: form,
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Row(
                                    children: [
                                      const Text('Set Category of task'),
                                      const SizedBox(width: 20),
                                      DropdownButton(
                                        items: categories.map((level) {
                                          return DropdownMenuItem(
                                              value: level, child: Text(level));
                                        }).toList(),
                                        onChanged:
                                            utilController.selectCategory,
                                        value:
                                            utilController.category ?? 'Home',
                                        elevation: 10,
                                        dropdownColor: Colors.purple[300],
                                        style: TextStyle(color: Colors.white),
                                        iconSize: 50,
                                        iconEnabledColor: Colors.purple[300],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // save button ( Insertion )
                                SizedBox(
                                  width: 100,
                                  child: CustomButton(
                                      title: 'Save',
                                      onTap: () async {
                                        note = NoteModel(
                                            title: title,
                                            description: description,
                                            percentage:
                                                utilController.start.toInt(),
                                            isDone: isDone == true? 1 : 0 ,
                                            category: utilController.category,
                                            level: utilController.level,
                                            user: user?.userId);
                                        int? row =
                                            await noteController.createNode(note: note);
                                        print(' rowV  $row');
                                        Constant.showSnackBar('has been created', context);
                                      }),
                                )
                              ],
                            );
                          },
                        );
                      },
                      isDismissible: true,
                      elevation: 10,
                      backgroundColor: Colors.deepPurple.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))));
                },
                tooltip: 'add note',
                child: Icon(
                  Icons.add,
                  color: Colors.black38,
                  size: 40,
                )),
          ),

          // BottomNavigationBar & his body
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            selectedItemColor:
                utilController.selector == 0 || utilController.selector == 2
                    ? Colors.grey.shade300
                    : Colors.purple,
            backgroundColor:
                utilController.selector == 0 || utilController.selector == 2
                    ? Colors.purple.shade300
                    : Colors.grey.shade300,
            currentIndex: utilController.selector,
            onTap: utilController.selectScreen,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home', tooltip: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note_add_outlined),
                  label: 'Projects',
                  tooltip: 'Projects'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  tooltip: 'Profile'),
            ],
          ),
          body: pages[utilController.selector],
        );
      },
    );
  }
}
