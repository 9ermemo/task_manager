import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/CONST/constant.dart';
import 'package:task_manager/controller/note_controller.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/controller/util_controller.dart';
import 'package:task_manager/model/note_model.dart';
import 'package:task_manager/model/user_model.dart';
import '../widgets/custom_dialogh.dart';

class HomePage extends StatelessWidget {
  UserModel? user;

  HomePage({this.user});

  final userController = Get.find<UserController>();
  final utilController = Get.find<UtilController>();
  final noteController = Get.put<NoteController>(NoteController());

  int currentValue = 0;

  Widget thereIsNoteNote() {
    return Center(
      child: Column(
        children: [
          Text('Seems there ',
              style: TextStyle(
                  fontSize: 10,
                  backgroundColor: Colors.grey[300],
                  color: Colors.white)),
          Padding(
              child: Text('Not task find !',
                  style: TextStyle(
                      fontSize: 10,
                      backgroundColor: Colors.grey[300],
                      color: Colors.white)),
              padding: const EdgeInsets.only(left: 20, top: 30, bottom: 40)),
          Image.asset('images/assets/oups.jpg'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(noteController.notesList.length);
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
              foregroundImage:
                  ExactAssetImage('images/assets/add_picture.png')),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.purple[300],
      drawer: Drawer(
        shape: RoundedRectangleBorder(
            side: BorderSide(
          width: 3,
          color: Colors.deepPurple.shade200,
        )),
        elevation: 10,
        backgroundColor: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            // state m for updating picture in drawer
            GetBuilder<UserController>(
              builder: (notUsed) {
                return DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.purple.shade300.withOpacity(0.3)),
                  margin: const EdgeInsets.all(50),
                  // button around picture
                  child: InkWell(
                      onTap: () async {
                        await userController.getImage();
                        user = UserModel(
                          userId: userController.user?.userId,
                          fullName: userController.user?.fullName,
                          email: userController.user?.email,
                          image: userController.image?.path,
                        );
                        await userController.updateImage(user: user);
                      },
                      // picture
                      child: userController.isLoading
                          ? Image.asset('images/assets/PERSON.jpg')
                          : Container(
                              child: Image.network(
                                  '${userController.user?.image}'))),
                );
              },
            ),

            // ListsTile below picture in drawer
            ListTile(
              title: Text('${noteController.userController.user?.fullName}'),
              trailing: const Icon(Icons.edit_off),
              onTap: () {
                print('${user?.fullName}');
              },
              leading: const Icon(Icons.person),
            ),
            ListTile(
              title: Text('${noteController.userController.user?.email}'),
              trailing: const Icon(Icons.edit_off),
              onTap: () {
                print('${noteController.userController.user?.email}');
              },
              leading: const Icon(Icons.mail),
            ),
            ListTile(
              title: const Text('Categories'),
              onTap: () {
                print('Categories');
              },
              leading: const Icon(Icons.category_rounded),
            ),
            ListTile(
              title: const Text('Tasks Done'),
              onTap: () {
                print('Tasks Done');
              },
            ),
            ListTile(
              title: const Text('To Do'),
              onTap: () {
                print('To do');
              },
            ),
            // Deconnexion
            ListTile(
              title: Text(
                'Deconnexion',
                style: TextStyle(color: Colors.red.shade600),
              ),
              onTap: () {
                userController.logOut();
              },
            ),
          ],
        ),
      ),
      body: noteController.notesList == null
          ? Center(child: thereIsNoteNote())
          : GetBuilder<NoteController>(builder: (_) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(height: 30),
                  // put listview into SizedBox for avoiding h & w ListView problem
                  SizedBox(
                    width: 150,
                    height: 130,
                    child: ListView.builder(
                        itemCount: noteController.categoryList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Container(
                            width: 150,
                            height: 130,
                            margin: EdgeInsets.all(6),
                            // container decorations
                            decoration: BoxDecoration(
                              // set Gradient around container
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.shade300,
                                    Colors.deepPurple.shade300,
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft),
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
                            // set name & number of tasks
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  title: Text(
                                      '${noteController.categoryList[index].category}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          letterSpacing: 6)),
                                  subtitle: Text(
                                      '${noteController.categoryList[index].numberOfTask} Tasks',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onTap: () {
                                    print('$index Tasks');
                                  },
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // todo & his number
                            const Text('Todos ', style: TextStyle(fontSize: 17)),
                            Text('${noteController.notesList.length}',
                                style:
                                    TextStyle(fontSize: 17, color: Constant.purple)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    // go to Projects screen
                    onTap: () {
                      //  Get.to(() => Projects(),transition: Transition.zoom, duration: Duration(seconds: 1));
                    },
                    // set note data from database
                    child: ListView.builder(
                        itemCount: noteController.notesList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        itemBuilder: (_, index0) {
                          return Container(
                            height: 150,
                            margin: EdgeInsets.all(6),
                            // container decorations
                            decoration: BoxDecoration(
                              // set Gradient around container
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.shade300,
                                    Colors.deepPurple.shade300,
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft),
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
                            // set name & number of tasks
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 10),
                              child: Column(
                                // mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(18),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // category
                                        Text(noteController
                                            .notesList[index0].category
                                            .toString()),
                                        // check if category is done or not
                                      ],
                                    ),
                                  ),
                                  // task title'
                                  Text(
                                      noteController.notesList[index0].title
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: 10),
                                  // task date
                                  Text(
                                      '${noteController.notesList[index0].noteDate}'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // task time
                                      Text(
                                          '${noteController.notesList[index0].noteTime}'),
                                      Row(
                                        children: [
                                          // paint an circle for levels
                                          Container(
                                            decoration: BoxDecoration(
                                                color: noteController
                                                            .notesList[index0]
                                                            .level ==
                                                        'High'
                                                    ? Colors.red
                                                    : noteController
                                                                .notesList[
                                                                    index0]
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
                                          Text(
                                              '${noteController.notesList[index0].level}'),
                                          // Edite level of task & show dialog
                                          IconButton(
                                            onPressed: () {
                                              var setLevel;
                                              showCustomDialog(
                                                submit: () {
                                                  // update method
                                                  NoteModel oldNote = NoteModel(
                                                    noteId: noteController
                                                        .notesList[index0]
                                                        .noteId,
                                                    user: user?.userId,
                                                    title: noteController
                                                        .notesList[index0]
                                                        .title,
                                                    description: noteController
                                                        .notesList[index0]
                                                        .description,
                                                    percentage: noteController
                                                        .notesList[index0]
                                                        .percentage,
                                                    isDone: noteController
                                                        .notesList[index0]
                                                        .isDone,
                                                    noteDate: noteController
                                                        .notesList[index0]
                                                        .noteDate,
                                                    noteTime: noteController
                                                        .notesList[index0]
                                                        .noteTime,
                                                    category: noteController
                                                        .notesList[index0]
                                                        .category,
                                                    level: setLevel,
                                                  );
                                                  noteController.updateNote(
                                                      oldNote: oldNote);
                                                },
                                                title:
                                                    const Text('Change level'),
                                                child: TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Edite Level',
                                                            border:
                                                                OutlineInputBorder()),
                                                    onChanged: (value) {
                                                      setLevel = utilController
                                                          .level = value;
                                                    }),
                                                context: context,
                                              );
                                            },
                                            icon: Icon(Icons.edit_off),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }),
    );
  }

}
