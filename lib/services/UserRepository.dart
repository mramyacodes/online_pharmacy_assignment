import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:online_pharmacy_assignment/models/UserDataModel.dart';
//import 'package:searching_list_with_json/lib/MedicinesDataModel.dart';

List<UserDataModel> parseUser(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var users = list.map((e) => UserDataModel.fromJson(e)).toList();
  return users;
}

Future<List<UserDataModel>> ReadJsonData() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('lib/data/products.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => UserDataModel.fromJson(e)).toList();
}
