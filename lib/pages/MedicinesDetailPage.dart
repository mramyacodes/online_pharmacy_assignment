import 'package:flutter/material.dart';
import 'package:online_pharmacy_assignment/models/MedicinesDataModel.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicineDetailsPage extends StatelessWidget {
  final MedicinesDataModel medicine;

  MedicineDetailsPage({required this.medicine});

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Medicine"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Center(
                child: Hero(
                  tag: medicine.id.toString(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(medicine.imageUrl.toString()),
                    radius: 100.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 22.0,
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
                height: 12.0,
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
                height: 12.0,
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
                height: 12.0,
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.vertical,
              //     child: Padding(
              //       padding: const EdgeInsets.only(
              //           left: 12.0, right: 12.0, bottom: 20.0),
              //       child: Text(
              //         medicine.category.toString(),
              //         textAlign: TextAlign.justify,
              //         style: const TextStyle(
              //           fontSize: 16.0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Text('Category : ' + medicine.category.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
