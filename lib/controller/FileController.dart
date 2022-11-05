// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' as rootBundle;
// import 'package:online_pharmacy_assignment/models/_OrdersDetail.dart';
// import 'package:online_pharmacy_assignment/widgets/fileManager.dart';

// class FileController extends ChangeNotifier {
//   String _text = '';
//   late OrdersDataModel _order;

//   String get text => _text;
//   OrdersDataModel get user => _order;

//   readOrder() async {
//     final result = await FileManager().readJsonFile();

//     if (result != null) {
//       _order = OrdersDataModel.fromJson(await FileManager().readJsonFile());
//     }

//     notifyListeners();
//   }

//   writeOrder() async {
//     OrdersDataModel orders;
//     Map<String, dynamic> jsonmap = jsonDecode(ReadJsonData().toString());
//     String allorders = jsonEncode(jsonmap);
//     orders = allorders as OrdersDataModel;
//     _order = await FileManager().writeJsonFile(orders);
//     notifyListeners();
//   }
// }

// Future<List<OrdersDataModel>> ReadJsonData() async {
//   final jsondata =
//       await rootBundle.rootBundle.loadString('lib/data/orders.json');
//   final list = json.decode(jsondata) as List<dynamic>;
//   return list.map((e) => OrdersDataModel.fromJson(e)).toList();
// }
