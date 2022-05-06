class UserModel {
  int? userId;
  String? fullName;
  String? email;
  String? password;
  String? image;

  UserModel({this.userId, this.fullName, this.email, this.password , this.image});

  factory UserModel.fromJson(Map<String , dynamic> json) {
    return UserModel(
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
    );
  }
}
