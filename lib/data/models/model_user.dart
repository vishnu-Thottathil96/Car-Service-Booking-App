import 'package:motox/data/models/model_car.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String profilePhoto;
  List<Car>? cars;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.profilePhoto = '',
      this.cars});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePhoto: json['image'],
    );
  }
}
