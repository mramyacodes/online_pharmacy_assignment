import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:online_pharmacy_assignment/models/_OrdersDetail.dart';
import 'package:online_pharmacy_assignment/pages/HomeScreen.dart';

import '../models/OrdersDetail.dart';

class MainScreen extends StatefulWidget {
  int userid;
  MainScreen({required this.userid});
  static const String routeName = '/product-list';

  @override
  _MainScreenState createState() => _MainScreenState(userid: userid);
}

class _MainScreenState extends State<MainScreen> {
  int userid;
  _MainScreenState({required this.userid});
  List<OrdersDataModel> allProducts = [];
  List<OrdersDataModel> filteredProducts = [];

  initState() {
    readJsonFile();
  }

  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('lib/data/orders.json');
    final productData = await json.decode(response);

    var list = productData["orders"] as List<dynamic>;

    setState(() {
      allProducts = [];
      allProducts = list.map((e) => OrdersDataModel.fromJson(e)).toList();
      filteredProducts = allProducts;
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
                (element.status.toString().contains("O") ||
                    element.status.toString().contains("I")),
          )
          .toList();
      if (results.length > 3) {
        filteredProducts.clear();
        filteredProducts.add(results[0]);
        filteredProducts.add(results[1]);
        filteredProducts.add(results[2]);
      } else {
        filteredProducts = results;
      }
    }
  }

  String getStsdesc(String Sts) {
    if (Sts == 'I') {
      return 'Incomplete';
    } else {
      return 'Open';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        //    backgroundColor: Color.fromARGB(70, 255, 64, 128),
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (allProducts.length > 0)
            filteredProducts.isEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      'No Pending Orders',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      'Your Pending Orders',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredProducts.length,
                itemBuilder: (BuildContext context, index) {
                  return Dismissible(
                    key: ValueKey(filteredProducts[index].id.toString()),
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
                                'Order ID - ${filteredProducts[index].id}'),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status : ${getStsdesc(filteredProducts[index].status.toString())} ',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Items : ${filteredProducts[index].itemcount}',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                  textAlign: TextAlign.right,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Total : ₹${filteredProducts[index].total!}',
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
                          },
                        )),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            )

            // else
            // Container(child: Text("No products"),)
          ],
        ),
      ),
    );
  }
}
