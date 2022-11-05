// ignore: file_names
import 'dart:collection';

class MedicinesDataModel {
  int? id;
  String? name;
  String? category;
  String? imageUrl;
  String? description;
  double? price;

  MedicinesDataModel(this.id, this.name, this.category, this.imageUrl,
      this.description, this.price);

  // MedicinesDataModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   category = json['category'];
  //   imageURL = json['imageUrl'];
  //   description = json['description'];
  //   price = json['price'];
  // }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = HashMap();
    result.addAll({
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'price': price
    });
    return result;
  }

  factory MedicinesDataModel.fromJson(Map<String, dynamic> json) {
    return MedicinesDataModel(json['id'], json['name'], json['category'],
        json['imageUrl'], json['description'], json['price'] as double);
  }
}
