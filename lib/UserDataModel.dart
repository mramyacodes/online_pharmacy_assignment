// ignore: file_names
import 'dart:collection';

class UserDataModel {
  int? id;
  String? name;
  String? email;
  String? pwd;
  List orders = List.empty();

  UserDataModel(this.id, this.name, this.email, this.pwd, this.orders);

  // UserDataModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   category = json['category'];
  //   imageURL = json['imageUrl'];
  //   oldPrice = json['oldPrice'];
  //   price = json['price'];
  // }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = HashMap();
    result.addAll(
        {'id': id, 'name': name, 'email': email, 'pwd': pwd, 'orders': orders});
    return result;
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        json['id'], json['name'], json['email'], json['pwd'], json['orders']);
  }
}
