import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_pharmacy_assignment/models/OrdersDetail.dart';
import 'package:online_pharmacy_assignment/pages/OrdersScreen.dart';
import 'package:online_pharmacy_assignment/pages/ShoppingCart.dart';
import 'package:provider/provider.dart';
import '../controller/FileController.dart';
import 'package:decorated_icon/decorated_icon.dart';

class OrdersDashboard extends StatefulWidget {
  final OrdersDataModel order;
  final int userId;

  OrdersDashboard({required this.order, required this.userId});

  @override
  State<OrdersDashboard> createState() =>
      _OrdersDashboardState(order: order, userId: userId);
}

class _OrdersDashboardState extends State<OrdersDashboard> {
  final OrdersDataModel order;
  final int userId;
  _OrdersDashboardState({required this.order, required this.userId});
  late List<MedicineOrder> filteredProducts;
  late int userid;
  late int maxid;
  List<OrdersDataModel> allProducts = [];
  List<OrdersDataModel> userOrders = [];

  initState() {
    userid = userId;
    filteredProducts = order.medorders;
    readJsonFileOrders();
  }

  Future<void> readJsonFileOrders() async {
    final String response = await rootBundle.loadString('lib/data/orders.json');
    final productData = await json.decode(response);

    var list = productData["orders"] as List<dynamic>;

    setState(() {
      allProducts = [];
      allProducts = list.map((e) => OrdersDataModel.fromJson(e)).toList();
      userOrders = allProducts;
      allProducts.sort((a, b) => a.id!.compareTo(b.id!));
      maxid = allProducts.last.id! + 1;
      _runFilter(userid.toString());
    });
  }

  void _runFilter(String searchKeyword) {
    List<OrdersDataModel> results = [];

    if (searchKeyword.isEmpty) {
      results = allProducts;
    } else {
      results = allProducts
          .where(
            (element) =>
                element.userid
                    .toString()
                    .contains(searchKeyword.toLowerCase()) &&
                (element.status.toString().contains("C")),
          )
          .toList();
      if (results.length > 3) {
        userOrders.clear();
        userOrders.add(results[0]);
        userOrders.add(results[1]);
        userOrders.add(results[2]);
      } else {
        userOrders = results;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your cart contains ${filteredProducts.length} items',
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        icon: Icon(Icons.search_rounded),
                        color: Colors.blueAccent,
                        iconSize: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingCart()),
                          );
                        }),
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        icon: Icon(Icons.shopping_cart_checkout_outlined),
                        color: Colors.blueAccent,
                        iconSize: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrdersScreen(
                                      order: order,
                                      maxid: maxid,
                                    )),
                          );
                        })
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Buy Again',
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userOrders.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        color: Color.fromARGB(205, 249, 178, 230),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Order ID - ${userOrders[index].id}'),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status : Complete ',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Items : ${userOrders[index].itemcount}',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Total : ₹${userOrders[index].total!}',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            // print(jsonEncode(products[index]));
                            // Navigator.of(context).pushNamed(
                            //     ProductDetailScreen.routeName,
                            //     arguments: jsonEncode(filteredProducts[index]));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrdersScreen(
                                        order: userOrders[index],
                                        maxid: maxid,
                                      )),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ])),
    ));
  }
}
