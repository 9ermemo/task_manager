import 'package:sqflite/sqflite.dart';
import 'package:task_manager/model/user_model.dart';
import 'package:task_manager/services/services.dart';

class UserServices {
  //create user
  Future<int> signUp({ UserModel? user}) async {
    Database? database = await  Services().conn();
    print(  user?.email);
    int rawInserted = await database!.rawInsert('''
      INSERT INTO 'User'( 'image' , 'fullName' , 'email' , 'password')
      VALUES( '${user?.image}' , '${user?.fullName}' , '${user?.email}' , '${user?.password}' )
     ''');
    return rawInserted;
  }

  // verify email & password
  dynamic check(List<Map<String , dynamic>> data, { UserModel? user}) {
    print('user data=  $data');
    if (data.isEmpty) {
      return -1;
    }
    if (data[0]["email"] == user?.email &&
        data[0]["password"] != user?.password) {
      return -2;
    }
    if (data[0]["email"] != user?.email &&
        data[0]["password"] == user?.password) {
      return -3;
    } else {
        List<UserModel> newData = data.map((element) => UserModel.fromJson(element)).toList();
      return newData;
    }
  }

  //login
  Future signIn({UserModel? user}) async {
    Database? database = await Services().conn();
    List<Map<String , dynamic>> data = await database!.rawQuery('''
      SELECT *
      FROM User
     WHERE email = '${user?.email}'
    ''');
    return check(data,user:user );
  }

  // get User information
  Future<List<Map>> getUser({UserModel? user}) async{
    Database? database = await Services().conn();
    List<Map<String , dynamic>> data = await database!.rawQuery('''
      SELECT *
      FROM User
     WHERE email = '${user?.email}'
    ''');
    return data;
  }

  // delete Account
  Future<int> deleteAccount({ UserModel? user}) async {
    Database? database = await Services().conn();
   int isDeleted = await database!.rawDelete
      ('''
      DELETE
      FROM User 
      WHERE userId = '${user?.userId}'
    ''');
   return isDeleted;
  }

  Future updateImage({UserModel? user}) async{
    Database? database = await Services().conn();
    print(  user?.email);
    int rawInserted = await database!.rawInsert('''
      INSERT INTO 'User'( 'image' , 'fullName' , 'email' , 'password')
      VALUES( '${user?.image}' , '${user?.fullName}' , '${user?.email}' , '${user?.password}' )
     ''');
    return rawInserted;
  }

  // update Account
  Future<int> updateAccount({ UserModel? user}) async {
    Database? database = await Services().conn();
    int rawUpdated = await database!.rawUpdate
      ('''
      UPDATE User 
      SET 
      fullName = '${user?.fullName}',
      email = '${user?.email}',
      password = '${user?.password}',
      image = '${user?.image}'
      WHERE userId = ${user?.userId}
      ''');
    return rawUpdated;
  }


}
