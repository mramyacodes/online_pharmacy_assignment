import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:online_pharmacy_assignment/models/MedicinesDataModel.dart';
import 'package:online_pharmacy_assignment/widgets/search_widget.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  late List<MedicinesDataModel> medicines;
  String query = '';
  Map<String, dynamic> jsonmap = jsonDecode(ReadJsonData().toString());

  @override
  void initState() {
    super.initState();
    String allMedicines = jsonEncode(jsonmap);
    medicines = allMedicines as List<MedicinesDataModel>;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];

                  return buildMedicine(medicine);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchMedicine,
      );

  Widget buildMedicine(MedicinesDataModel medicine) => ListTile(
        leading: Image.network(
          medicine.imageUrl.toString(),
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(medicine.name.toString()),
        subtitle: Text(medicine.toString()),
      );

  void searchMedicine(String query) {
    // String allMedicines = jsonEncode(jsonmap);
    // final medicines = allMedicines..startsWith(medicine) {
    //   final titleLower = medicines.
    //   final authorLower = medicine.toString().toLowerCase();
    //   final searchLower = query.toLowerCase();

    //   return titleLower.contains(searchLower) ||
    //       authorLower.contains(searchLower);
    // }).toList();

    // setState(() {
    //   this.query = query;
    //   this.medicines = medicines;
    // });
  }
}

Future<List<MedicinesDataModel>> ReadJsonData() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('lib/data/products.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => MedicinesDataModel.fromJson(e)).toList();
}
