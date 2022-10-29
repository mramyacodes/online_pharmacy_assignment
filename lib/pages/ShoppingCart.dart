import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pharmacy_assignment/widgets/LoadingView.dart';
import 'package:online_pharmacy_assignment/services/MedicineRepository.dart';
import 'package:online_pharmacy_assignment/widgets/MedicineTile.dart';
import 'package:online_pharmacy_assignment/models/MedicinesDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;

/*
class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}


class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ReadJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var items = data.data as List<MedicinesDataModel>;
          return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Image(
                            image:
                                NetworkImage(items[index].imageUrl.toString()),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  items[index].name.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(items[index].price.toString()),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<List<MedicinesDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('lib/data/products.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => MedicinesDataModel.fromJson(e)).toList();
  }
}
*/

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<MedicinesDataModel> _medicines = <MedicinesDataModel>[];
  List<MedicinesDataModel> _medicinesDisplay = <MedicinesDataModel>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    ReadJsonData().then((value) {
      setState(() {
        _isLoading = false;
        _medicines.addAll(value);
        _medicinesDisplay = _medicines;
        //print(_medicinesDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Medicines List'),
      // ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0
                    ? _searchBar()
                    : MedicineTile(medicine: this._medicinesDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _medicinesDisplay.length + 1,
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _medicinesDisplay = _medicines.where((u) {
              var name = u.name.toString().toLowerCase();
              var description = u.description.toString().toLowerCase();
              return name.contains(searchText) ||
                  description.contains(searchText);
            }).toList();
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Medicines',
        ),
      ),
    );
  }
}
