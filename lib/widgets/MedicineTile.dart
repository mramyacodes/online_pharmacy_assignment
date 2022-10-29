import 'package:flutter/material.dart';
import 'package:online_pharmacy_assignment/models/MedicinesDataModel.dart';
import 'package:online_pharmacy_assignment/pages/MedicinesDetailPage.dart';

class MedicineTile extends StatelessWidget {
  final MedicinesDataModel medicine;

  MedicineTile({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: medicine.id.toString(),
              child: CircleAvatar(
                backgroundImage: NetworkImage(medicine.imageUrl.toString()),
              ),
            ),
            title: Text(medicine.name.toString()),
            subtitle: Text(medicine.description.toString()),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MedicineDetailsPage(medicine: medicine)));
            },
          ),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
