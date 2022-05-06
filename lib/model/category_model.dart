


class CategoryModel{

  String? category;
  int? numberOfTask;


  CategoryModel({this.category,this.numberOfTask});



  factory CategoryModel.fromJson(Map<String , dynamic>json){
    return CategoryModel(
      category: json['category'],
      numberOfTask: json['numberOfTask'],
    );
  }


}
