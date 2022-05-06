
class NoteModel {
  int? noteId;
  String? title;
  String? description;
  int? percentage;
  int? isDone;
  String? noteTime; //*
  String? noteDate; // *
  String? category;
  String? level;
  int? user;

  NoteModel({
    this.noteId,
    this.title,
    this.description,
    this.percentage ,
    this.isDone,
    this.noteTime,
    this.noteDate,
    this.category,
    this.level,
    this.user
  });

  factory NoteModel.fromJson(Map<String , dynamic>json){
    return NoteModel(
      noteId: json['noteId'],
      title: json['title'],
      description: json['description'],
      percentage :  json['percentage'] ,
      isDone: json['isDone'],
      noteTime: json['noteTime'],
       noteDate: json['noteDate'],
      category: json['category'],
      level: json['level'],
      user: json['user'],
    );
  }


}
