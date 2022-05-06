import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../CONST/constant.dart';
import '../../controller/note_controller.dart';
import '../../controller/util_controller.dart';
import '../../model/note_model.dart';
import '../widgets/custom_button.dart';

class Projects extends StatelessWidget {
  Projects({Key? key}) : super(key: key);

  List<String> levels = ['High', 'Medium', 'Easy'];
  List<String> categories = [
    'Home',
    'Sport',
    'Work',
    'Family',
    'Shopping',
    'Health',
    'Personal'
  ];

// text-field variables
  String? title;
  String? description;

// slider variables
  double min = 0;
  double max = 100;

  NoteModel? oldNote;

  int isDone = 0;

  //global key
  GlobalKey<FormState> form = GlobalKey<FormState>();

  final utilController = Get.find<UtilController>();
  final noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('P R O J E C T S'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white)),
        backgroundColor: Colors.purple[300],
        body: noteController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : GetBuilder<NoteController>(
                builder: (notes) => ListView.builder(
                    itemCount: noteController.notesList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                    itemBuilder: (context, int index) {
                      return Container(
                        height: 150,
                        margin: EdgeInsets.all(6),
                        // container decorations
                        decoration: BoxDecoration(
                          // set Gradient around container
                          gradient: LinearGradient(colors: [
                            Colors.purple.shade300,
                            Colors.deepPurple.shade300,
                          ], begin: Alignment.topRight, end: Alignment.topLeft),
                          borderRadius: BorderRadius.circular(20),
                          // set shadows
                          boxShadow: [
                            BoxShadow(
                                color: Colors.purple.shade400,
                                offset: Offset(-2, -2),
                                spreadRadius: 1,
                                blurRadius: 5),
                            BoxShadow(
                                color: Colors.purple.shade400,
                                offset: Offset(2, 2),
                                spreadRadius: 1,
                                blurRadius: 5),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // category
                                  Text('${notes.notesList[index].category}'),
                                  // delete note
                                  IconButton(
                                      onPressed: () async {
                                        oldNote = NoteModel(
                                          noteId: noteController
                                              .notesList[index].noteId,
                                          user: noteController
                                              .notesList[index].user,
                                          isDone: noteController
                                              .notesList[index].isDone,
                                          description: noteController
                                              .notesList[index].description,
                                          level: noteController
                                              .notesList[index].level,
                                          category: noteController
                                              .notesList[index].category,
                                          percentage: noteController
                                              .notesList[index].percentage,
                                          title: noteController
                                              .notesList[index].title,
                                          noteTime: noteController
                                              .notesList[index].noteTime,
                                          noteDate: noteController
                                              .notesList[index].noteDate,
                                        );
                                        int deleted = await noteController
                                            .deleteNote(note: oldNote);
                                        print(deleted);
                                        Constant.showSnackBar('has been deleted', context);
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.redAccent,
                                      )),
                                ],
                              ),
                              // task title'
                              Text('${notes.notesList[index].title}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(height: 10),
                              // task content
                              Text('${notes.notesList[index].description}',
                                  overflow: TextOverflow.ellipsis),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // paint an circle
                                      Container(
                                        decoration: BoxDecoration(
                                            color: noteController
                                                        .notesList[index]
                                                        .level ==
                                                    'High'
                                                ? Colors.red
                                                : noteController
                                                            .notesList[index]
                                                            .level ==
                                                        'Medium'
                                                    ? Colors.yellow
                                                    : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 10,
                                        height: 10,
                                        margin: EdgeInsets.all(5),
                                      ),
                                      // Enum { High , Medium & Easy }
                                      Text(
                                          '${noteController.notesList[index].level}'),
                                      // progressing % of this task
                                      const SizedBox(width: 5),
                                      Text(
                                          '${noteController.notesList[index].percentage} %')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // BottomSheet for editing exist data
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              //isScrollControlled: true,
                                              context: Get.overlayContext!,
                                              builder: (BuildContext context) {
                                                return GetBuilder<
                                                    UtilController>(
                                                  builder: (notUsed) {
                                                    return Column(
                                                      children: [
                                                        const SizedBox(
                                                            height: 5),
                                                        //Title & Content for textFiled
                                                        Form(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 50,
                                                                    right: 50),
                                                            child: Column(
                                                              children: [
                                                                TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Enter task Title',
                                                                    focusColor: Colors
                                                                        .purple
                                                                        .shade300,
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  cursorColor:
                                                                      Colors
                                                                          .purple,
                                                                  onChanged:
                                                                      (title) {
                                                                    this.title =
                                                                        title;
                                                                  },
                                                                  validator:
                                                                      (titleV) {
                                                                    if (titleV!
                                                                        .isEmpty) {
                                                                      return 'Is Empty';
                                                                    }
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    height: 7),
                                                                TextFormField(
                                                                  maxLines: 2,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Enter task Description',
                                                                    focusColor: Colors
                                                                        .purple
                                                                        .shade300,
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  cursorColor:
                                                                      Colors
                                                                          .purple,
                                                                  onChanged:
                                                                      (description) {
                                                                    this.description =
                                                                        description;
                                                                  },
                                                                  validator:
                                                                      (titleV) {
                                                                    if (titleV!
                                                                        .isEmpty) {
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 50.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  'Set Percentage'),
                                                              const SizedBox(
                                                                  width: 20),
                                                              Slider(
                                                                thumbColor:
                                                                    Colors.purple[
                                                                        300],
                                                                divisions: 10,
                                                                mouseCursor:
                                                                    MouseCursor
                                                                        .defer,
                                                                label: utilController
                                                                    .start
                                                                    .toString(),
                                                                value:
                                                                    utilController
                                                                        .start,
                                                                min: min,
                                                                max: max,
                                                                onChanged:
                                                                    utilController
                                                                        .selectValue,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // dropDown for level
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 50),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  'Set Level of task'),
                                                              const SizedBox(
                                                                  width: 20),
                                                              DropdownButton(
                                                                items: levels
                                                                    .map(
                                                                        (level) {
                                                                  return DropdownMenuItem(
                                                                      value:
                                                                          level,
                                                                      child: Text(
                                                                          level));
                                                                }).toList(),
                                                                onChanged:
                                                                    utilController
                                                                        .selectLevel,
                                                                value: utilController
                                                                        .level ??
                                                                    'High',
                                                                elevation: 10,
                                                                dropdownColor:
                                                                    Colors.purple[
                                                                        300],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                iconSize: 50,
                                                                iconEnabledColor:
                                                                    Colors.purple[
                                                                        300],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // dropDown for category
                                                        Padding(
                                                          key: form,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 50),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  'Set Category of task'),
                                                              const SizedBox(
                                                                  width: 20),
                                                              DropdownButton(
                                                                items: categories
                                                                    .map(
                                                                        (level) {
                                                                  return DropdownMenuItem(
                                                                      value:
                                                                          level,
                                                                      child: Text(
                                                                          level));
                                                                }).toList(),
                                                                onChanged:
                                                                    utilController
                                                                        .selectCategory,
                                                                value: utilController
                                                                        .category ??
                                                                    'Home',
                                                                elevation: 10,
                                                                dropdownColor:
                                                                    Colors.purple[
                                                                        300],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                iconSize: 50,
                                                                iconEnabledColor:
                                                                    Colors.purple[
                                                                        300],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        // login button
                                                        SizedBox(
                                                          width: 100,
                                                          // update note
                                                          child: CustomButton(
                                                              title: 'Save',
                                                              onTap: () async {
                                                                int percent =
                                                                    utilController
                                                                        .start
                                                                        .toInt();
                                                                String
                                                                    category =
                                                                    utilController
                                                                        .category;
                                                                String level =
                                                                    utilController
                                                                        .level;
                                                                String? newTitle = title ??
                                                                    noteController
                                                                        .notesList[
                                                                            index]
                                                                        .title;
                                                                String?
                                                                    newDescription =
                                                                    description ??
                                                                        noteController
                                                                            .notesList[index]
                                                                            .description;
                                                                int? newPercentage = percent ==
                                                                        null
                                                                    ? noteController
                                                                        .notesList[
                                                                            index]
                                                                        .percentage
                                                                    : percent;
                                                                String? newCategory = category ==
                                                                        null
                                                                    ? noteController
                                                                        .notesList[
                                                                            index]
                                                                        .category
                                                                    : category;
                                                                String? newLevel = level ==
                                                                        null
                                                                    ? noteController
                                                                        .notesList[
                                                                            index]
                                                                        .level
                                                                    : level;
                                                                int? isDone =
                                                                    noteController
                                                                        .notesList[
                                                                            index]
                                                                        .isDone;
                                                                int? noteId =
                                                                    noteController
                                                                        .notesList[
                                                                            index]
                                                                        .noteId;
                                                                int? userId =
                                                                    noteController
                                                                        .notesList[
                                                                            index]
                                                                        .user;
                                                                oldNote =  NoteModel(
                                                                  noteId:
                                                                      noteId,
                                                                  title:
                                                                      newTitle,
                                                                  percentage:
                                                                      newPercentage,
                                                                  category:
                                                                      newCategory,
                                                                  level:
                                                                      newLevel,
                                                                  description:
                                                                      newDescription,
                                                                  isDone:
                                                                      isDone,
                                                                  user: userId,
                                                                );
                                                               int rowUpdated = await noteController.updateNote( oldNote: oldNote);
                                                               print(rowUpdated);
                                                                Constant.showSnackBar('has been updated', context);
                                                              }),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              isDismissible: true,
                                              elevation: 10,
                                              backgroundColor:
                                                  Colors.deepPurple.shade200,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          topLeft:
                                                              Radius.circular(
                                                                  20))));
                                        },
                                        icon: Icon(Icons.edit_off,
                                            color: Colors.lightBlue),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ));
  }
}
