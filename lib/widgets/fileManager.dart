// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';

// import 'package:online_pharmacy_assignment/models/_OrdersDetail.dart';

// class FileManager {
//   static FileManager _instance = new FileManager();

//   FileManager._internal() {
//     _instance = this;
//   }

//   factory FileManager() => _instance;

//   // Future<String> get _directoryPath async {
//   //   Directory directory = await getApplicationDocumentsDirectory();
//   //   return directory.path;
//   // }

//   Future<File> get _jsonFile async {
//     //final path = await _directoryPath;
//     return File('lib/data/orders.json');
//   }

//   Future<Map<String, dynamic>> readJsonFile() async {
//     String fileContent;

//     Map<String, dynamic> str = HashMap();
//     File file = await _jsonFile;

//     if (await file.exists()) {
//       try {
//         fileContent = await file.readAsString();
//         return json.decode(fileContent);
//       } catch (e) {
//         print(e);
//       }
//     }

//     return str;
//   }

//   Future<OrdersDataModel> writeJsonFile(OrdersDataModel order) async {
//     File file = await _jsonFile;
//     await file.writeAsString(json.encode(order));
//     return order;
//   }
// }

// Future<void> main() async {
//   String _text = (await FileManager().readJsonFile()) as String;
// }

// /*
// class jsonExample {
//   String fname = 'Ramya';
//   String lname = 'Mohan';
//   int age = 34;

//   Address addr = Address('2A, 13/22', '6th Street, Rajaji Nagar, Villivakkam',
//       'Chennai', '600049');
//   List children = List.empty();

//   jsonExample(this.fname, this.lname, this.age, this.addr, this.children) {
//     if (children == null) {
//       children = List.empty();
//     }
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> result = HashMap();
//     List list = [];
//     children.forEach((element) {
//       list.add(element);
//     });
//     result.addAll({
//       'fname': fname,
//       'lname': lname,
//       'age': age,
//       'address': addr.toJson(),
//       'children': list
//     });
//     return result;
//   }

//   factory jsonExample.fromJson(Map<String, dynamic> json) {
//     return jsonExample(json['fname'], json['lname'], json['age'] as int,
//         Address.fromJson(json['address']) as Address, json['children']);
//   }
// }

// class Address {
//   String doorNo;
//   String streetAddress;
//   String city;
//   String pincode;

//   Address(this.doorNo, this.streetAddress, this.city, this.pincode);

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> result = HashMap();
//     result.addAll({
//       'doorNo': doorNo,
//       'streetAddress': streetAddress,
//       'city': city,
//       'pincode': pincode
//     });
//     return result;
//   }

//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//         json['doorNo'], json['streetAddress'], json['city'], json['pincode']);
//   }
// }

// void main() {
//   String jsonStr =
//       '{    "fname":"Ramya","lname":"Mohan","age":34,"address":{"doorNo":"2A","streetAddress":"Rajaji Nagar","city":"Chennai","pincode":"600049"},"children":[]}';

//   //print("Input" + jsonStr);

//   Map<String, dynamic> jsonmap = jsonDecode(jsonStr);
//   String newjson = jsonEncode(jsonmap);

//   //print("output" + newjson);

//   Map<String, dynamic> jmap = jsonDecode(jsonStr);
//   jsonExample jsx = jsonExample.fromJson(jmap);
//   Map<String, dynamic> afterconversion = jsx.toJson();

//   String allnew = jsonEncode(afterconversion);
//   print(allnew);
// }
// */


 