import 'package:sqflite/sqflite.dart';
import 'package:task_manager/model/note_model.dart';
import 'package:task_manager/services/services.dart';

import '../model/user_model.dart';

class NoteServices {
  // dependency
  // NoteServices(NoteController noteController );

  // insert note
  Future<int> createNote({ NoteModel? note}) async {
    Database? database = await Services().conn();
    String level = '';
    String category = '';
    note?.level==null? note?.level = "High":note?.level;
    note?.category==null?  note?.category = "Home":note?.category ;
    //insert query
    int  rowInserted = await database!.rawInsert('''
     INSERT INTO Note
     ( 'title',
     'description',
     'noteTime' , 
     'noteDate' , 
     'percentage' , 
     'isDone' ,
     'category',
     'level',
     'userId')
      VALUES( '${note?.title}' ,
       '${note?.description}' ,
        CURRENT_TIME , 
        CURRENT_DATE ,
        '${note?.percentage} ', 
        '${note?.isDone}' ,
        '${note?.category}' ,
        '${note?.level}' ,
        '${note?.user}');
   ''');
    return rowInserted;
  }

  // read note
  Future<List<Map>> getAllNote({ UserModel? user } ) async {
    Database? database = await Services().conn();
    List<Map>  data = await database!.rawQuery('''
      SELECT *
      FROM Note
      WHERE userId = ${user?.userId}
      ''');
   return data;
  }

  // get by category
  Future<List<Map>> getNoteByCategory({ UserModel ? user}) async {
    Database? database = await Services().conn();
    // insert query
    List<Map> categories = await database!.rawQuery('''
      SELECT COUNT(noteId) as numberOfTask  , category
      FROM Note
      WHERE userId = ${user?.userId}
      GROUP BY category;
      ''');
    return categories;
  }


  // delete note
  Future<int> deleteNote({int? index}) async {
    Database? database = await Services().conn();
    int rowDeleted = await database!.rawDelete
        //delete query
        ('''
        DELETE
        FROM Note
        WHERE  noteId = $index
     ''');
    return rowDeleted;
  }

  // update note
  Future<int> updateNote({ NoteModel? note}) async {
    Database? database = await Services().conn();
    int rowUpdated = await database!.rawUpdate
        //update query
        ('''
        UPDATE Note
        SET 
        title = '${note?.title}',
        description = '${note?.description}',
        percentage = ${note?.percentage},
        isDone = ${note?.isDone},
        category = '${note?.category}',
        level ='${note?.level}'
        WHERE noteId = ${note?.noteId}
     ''');
    return rowUpdated;
  }
}
