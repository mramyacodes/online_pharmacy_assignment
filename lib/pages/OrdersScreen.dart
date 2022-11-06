import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_pharmacy_assignment/models/MedicinesDataModel.dart';
import 'package:online_pharmacy_assignment/models/OrdersDetail.dart';
import 'package:online_pharmacy_assignment/pages/ShoppingCart.dart';
import 'package:provider/provider.dart';
import '../controller/FileController.dart';
import 'package:decorated_icon/decorated_icon.dart';

import '../services/MedicineRepository.dart';

class OrdersScreen extends StatefulWidget {
  final OrdersDataModel order;
  final int maxid;

  OrdersScreen({required this.order, required this.maxid});

  @override
  State<OrdersScreen> createState() =>
      _OrdersScreenState(order: order, maxid: maxid);
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersDataModel order;
  final int maxid;
  _OrdersScreenState({required this.order, required this.maxid});
  late List<MedicineOrder> filteredProducts;

  List allmedicines = [];
  List<MedicinesDataModel> _medicines = <MedicinesDataModel>[];
  List<MedicinesDataModel> _medicinesDisplay = <MedicinesDataModel>[];
  List<OrdersDataModel> allOrders = [];
  initState() {
    if (order.id == 0) {
      order.id = maxid;
    }
    ReadJsonData().then((value) {
      setState(() {
        _medicines.addAll(value);
        _medicinesDisplay = _medicines;
        //print(_medicinesDisplay.length);
      });
    });

    readfromJsonOrdersFile().then((value) => allOrders);
    filteredProducts = order.medorders;
  }

  Future<void> _orderSubmit() async {
    List<OrdersDataModel> filteredOrders = [];
    String searchKeyword;
    searchKeyword = order.id.toString();
    filteredOrders = allOrders
        .where(
          (element) =>
              element.id.toString().contains(searchKeyword.toLowerCase()),
        )
        .toList();
    OrdersDataModel thisOrder;
    late int index;
    if (filteredOrders.isEmpty) {
      allOrders.add(order);
    } else {
      index = allOrders.indexWhere(
        (element) =>
            element.id.toString().contains(searchKeyword.toLowerCase()),
      );
      allOrders[index] = order;
    }
    //final File file = File('lib/data/orders.json');
    final _filePath = await _localFile;
    _filePath.writeAsString(jsonEncode(allOrders));
  }

  Future<File> get _localFile async {
    return File(
        'C:/Users/ramya/OneDrive/Documents/eLearn/Semester 2/CPAD/my_app/assignment_2/online_pharmacy_assignment/lib/data/orders.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Your cart contains ${filteredProducts.length} items',
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.search_rounded),
                    color: Colors.blueAccent,
                    iconSize: 50,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShoppingCart()),
                      );
                    }),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredProducts.length,
                itemBuilder: (BuildContext context, index) {
                  return Dismissible(
                    key: ValueKey(order.id.toString()),
                    background: Container(
                      color: Colors.redAccent,
                      child: Icon(Icons.delete, color: Colors.white, size: 40),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
                    ),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Please Confirm"),
                          content: Text("Are you sure you want to delete?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text("Cancel")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                                child: Text("Delete")),
                          ],
                        ),
                      );
                    },
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.endToStart) {
                        filteredProducts.removeAt(index);
                      }
                    },
                    child: Card(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        color: Color.fromARGB(205, 249, 178, 230),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Medicine ID - ${filteredProducts[index].medid}'),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quantity : ${filteredProducts[index].itemqty.toString()} ',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Total : ${filteredProducts[index].itemtotal}',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            // print(jsonEncode(products[index]));
                            // Navigator.of(context).pushNamed(
                            //     ProductDetailScreen.routeName,
                            //     arguments: jsonEncode(filteredProducts[index]));
                          },
                        )),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  _orderSubmit();
                },
                child: const Text('Check Out'),
                color: Colors.teal,
                textColor: Colors.white,
                height: 50,
              ),
            )
          ])),
    ));
  }
}

Future<List<OrdersDataModel>> readfromJsonOrdersFile() async {
  final String response = await rootBundle.loadString('lib/data/orders.json');
  final productData = await json.decode(response);

  var list = productData["orders"] as List<dynamic>;
  List<OrdersDataModel> allOrders = [];

  allOrders = [];
  allOrders = list.map((e) => OrdersDataModel.fromJson(e)).toList();
  return allOrders;
}
