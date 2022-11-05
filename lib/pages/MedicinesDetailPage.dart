import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:online_pharmacy_assignment/models/MedicinesDataModel.dart';
import 'package:online_pharmacy_assignment/pages/OrdersScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/OrdersDetail.dart';

class MedicineDetailsPage extends StatefulWidget {
  final MedicinesDataModel medicine;

  MedicineDetailsPage({required this.medicine});

  @override
  State<MedicineDetailsPage> createState() =>
      _MedicineDetailsPageState(medicine: medicine);
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  final MedicinesDataModel medicine;
  _MedicineDetailsPageState({required this.medicine});
  int quantity = 0;
  MedicineOrder medicineOrder = MedicineOrder(0, 1, 0);
  OrdersDataModel order = OrdersDataModel(10, 1, 0, 0, 'I', []);

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Error');
    }
  }

  void _handleAddTap() {
    setState(() {
      medicineOrder.medid = medicine.id;
      medicineOrder.itemqty = (medicineOrder.itemqty! + 1);
      medicineOrder.itemtotal = medicineOrder.itemqty! * medicine.price!;
      order.medorders = [];
      order.itemcount = medicineOrder.itemqty;
      order.total = medicineOrder.itemtotal;
    });
  }

  void _handleButton() {
    setState(() {
      order.medorders[0] = medicineOrder;
      order.itemcount = medicineOrder.itemqty;
      order.total = medicineOrder.itemtotal;
    });
  }

  void _handleSubTap() {
    setState(() {
      if (medicineOrder.itemqty! > 1) {
        medicineOrder.itemqty = (medicineOrder.itemqty! - 1);
      } else {
        medicineOrder.itemqty = 1;
        medicineOrder.medid = medicine.id;
        medicineOrder.itemtotal = medicineOrder.itemqty! * medicine.price!;
        order.medorders.add(medicineOrder);
        order.itemcount = medicineOrder.itemqty;
        order.total = medicineOrder.itemtotal;
      }
      order.medorders.add(medicineOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    medicineOrder.itemtotal = medicineOrder.itemqty! * medicine.price!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Medicine"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: medicine.id.toString(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(medicine.imageUrl.toString()),
                    radius: 30.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                medicine.name.toString(),
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${medicine.description}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '₹ ' + '${medicine.price}',
                    style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text('Category : ' + medicine.category.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16.0,
                  )),
              const SizedBox(height: 15),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                        onTap: () {
                          _handleSubTap();
                        }),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text('${medicineOrder.itemqty}',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 40.0,
                        )),
                    const SizedBox(
                      width: 12.0,
                    ),
                    GestureDetector(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                        onTap: () {
                          _handleAddTap();
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'Total cost : ₹ ${medicineOrder.itemtotal?.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5.0,
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  _handleButton();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrdersScreen(order: order)),
                  );
                  //HomeScreen();
                },
                color: Colors.blueAccent,
                textColor: Colors.white,
                height: 50,
                child: const Text('Add to cart',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 25.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
