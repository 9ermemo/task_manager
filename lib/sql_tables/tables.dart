



const String createUserTable = 'CREATE TABLE User('
    ' userId integer primary key autoincrement, '
    'image BLOB , '
    'fullName TEXT,'
    'email TEXT, '
    'password TEXT)  ';


const String createNodeTable ='CREATE TABLE Note('
     'noteId INTEGER primary key autoincrement,'
     'title TEXT, '
     'description TEXT,'
     'noteTime CURRENT_TIME,'
     ' noteDate CURRENT_DATE, '
     'percentage INTEGER NOT NULL,'
     'isDone BOOLEAN NOT NULL CHECK (isDone IN (0, 1)), '
     'category TEXT,'
     'level TEXT, '
     'userId INTEGER, FOREIGN KEY (userId) REFERENCES User(userId) )';

