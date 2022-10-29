import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;
import 'package:online_pharmacy_assignment/models/MedicinesDataModel.dart';
//import 'package:searching_list_with_json/lib/MedicinesDataModel.dart';

List<MedicinesDataModel> parseUser(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var medicines = list.map((e) => MedicinesDataModel.fromJson(e)).toList();
  return medicines;
}

Future<List<MedicinesDataModel>> ReadJsonData() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('lib/data/products.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => MedicinesDataModel.fromJson(e)).toList();
}
