import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/model/category_model.dart';
import 'package:task_manager/services/note_services.dart';

import '../model/note_model.dart';
import '../model/user_model.dart';

class NoteController extends GetxController {
  // list of notes

  // List<NoteModel> notesList = [];
  var notesList = <NoteModel>[];

  // List<CategoryModel> categoryList = [];
  var categoryList = <CategoryModel>[];


  bool isLoading = true;

  bool isDone = false;

  // dependency
  NoteModel? note;

  NoteServices? noteServices;

  NoteController({this.note});

  UserController userController = Get.find<UserController>();

  List<NoteModel> get noteData => notesList;

  List<CategoryModel> get categoryData => categoryList;

     taskIsDone(bool isDone) {
       update();
       return isDone;
      }



@override
void onInit() async {
  super.onInit();
  isLoading = true;
  await getAllNotes();
  await getNoteByCategory();
  isLoading = false;
}

// get all data
Future<void> getAllNotes() async {
  List data = await NoteServices().getAllNote(user: userController.user);
  notesList = data.map((notes) => NoteModel.fromJson(notes)).toList();
  update();
}

// get categories data
Future<void> getNoteByCategory() async {
  List data = await NoteServices().getNoteByCategory(user: userController.user);
  categoryList =
      data.map((category) => CategoryModel.fromJson(category)).toList();
  update();
}

// update data
Future<int> updateNote({NoteModel? oldNote}) async {
  // if note filed is null we must user old data
  note = oldNote ;
  int rowUpdated = await NoteServices().updateNote(note: oldNote);
  onInit();
  Get.back();
  return rowUpdated;
}

// delete data
Future<int> deleteNote({NoteModel? note}) async {
  int deleted = await NoteServices().deleteNote(index: note?.noteId);
  onInit();
  Get.back();
  return deleted;
}

// create data
Future<int?> createNode({NoteModel? note}) async {
  int? rowInserted = await NoteServices().createNote(note: note);
  print(note?.title);
  onInit();
  Get.back();
  return rowInserted;
}


}
