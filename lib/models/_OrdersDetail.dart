// ignore: file_names
import 'dart:collection';
import 'dart:convert';
import 'dart:core';

class _OrdersDataModel {
  int? id;
  int? userid;
  double? total;
  int? itemcount;
  String? status;
  MedicineOrder medorder;

  _OrdersDataModel(this.id, this.userid, this.total, this.itemcount,
      this.status, this.medorder) {
    id ??= 0;
    userid ??= 0;
    total ??= 0;
    status ??= '';
    medorder = medorder;
  }

  // _OrdersDataModel.fromJson(Map<String, dynamic> json) {
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
      'userid': userid,
      'total': total,
      'itemcount': itemcount,
      'status': status,
      'medorder': medorder
    });
    return result;
  }

  factory _OrdersDataModel.fromJson(Map<String, dynamic> json) {
    return _OrdersDataModel(
        json['id'] as int,
        json['userid'] as int,
        json['total'] as double,
        json['itemcount'] as int,
        json['status'],
        MedicineOrder.fromJson(json['medorder']) as MedicineOrder);
  }
}

class MedicineOrder {
  int? medid;
  int? itemqty;
  double? itemtotal;

  MedicineOrder(this.medid, this.itemqty, this.itemtotal) {
    medid ??= 0;
    itemqty ?? 0;
    itemtotal ??= 0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = HashMap();
    result.addAll({'medid': medid, 'itemqty': itemqty, 'itemtotal': itemtotal});
    return result;
  }

  factory MedicineOrder.fromJson(Map<String, dynamic> json) {
    return MedicineOrder(json['medid'], json['itemqty'], json['itemtotal']);
  }
}
/*
void main() {
  String jsonStr =
      '{"id": 1,      "userid": 1,      "total": 10,      "itemcount": 1,      "status": "O",      "medorder": {"medid": 1, "itemqty": 1, "itemtotal": 10}  }';

  //print("Input" + jsonStr);

  Map<String, dynamic> jsonmap = jsonDecode(jsonStr);
  String newjson = jsonEncode(jsonmap);

  //print("output" + newjson);

  Map<String, dynamic> jmap = jsonDecode(jsonStr);
  _OrdersDataModel jsx = _OrdersDataModel.fromJson(jmap);
  Map<String, dynamic> afterconversion = jsx.toJson();

  String allnew = jsonEncode(afterconversion);
  print(allnew);
}
*/
