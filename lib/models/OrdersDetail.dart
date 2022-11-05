import 'dart:collection';
import 'dart:ui';

class OrdersDataModel {
  int? id;
  int? userid;
  double? total;
  int? itemcount;
  String? status;
  List<MedicineOrder> medorders;

  OrdersDataModel(this.id, this.userid, this.total, this.itemcount, this.status,
      this.medorders) {
    id ??= 0;
    userid ??= 0;
    total ??= 0;
    status ??= '';
    medorders = [];
  }

  factory OrdersDataModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['medorder'] as List;
    List<MedicineOrder> medordersList =
        list.map((i) => MedicineOrder.fromJson(i)).toList();

    return OrdersDataModel(
        parsedJson['id'],
        parsedJson['userid'],
        parsedJson['total'],
        parsedJson['itemcount'],
        parsedJson['status'],
        medordersList);
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
