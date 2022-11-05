import 'package:flutter/material.dart';
import 'package:online_pharmacy_assignment/models/OrdersDetail.dart';
import 'package:provider/provider.dart';
import '../controller/FileController.dart';

class OrdersScreen extends StatefulWidget {
  final OrdersDataModel order;

  OrdersScreen({required this.order});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState(order: order);
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersDataModel order;

  _OrdersScreenState({required this.order});
  late List<MedicineOrder> filteredProducts;

  initState() {
    filteredProducts = order.medorders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Your cart contains',
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
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
                              'Order ID - ${filteredProducts[index].medid}'),
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
        ]),
      ),
    ));
  }
}
