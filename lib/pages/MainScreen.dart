import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pharmacy_assignment/UserDataModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //     color: Colors.yellow.shade100,
    //     alignment: Alignment.center,
    //     child: const Text(
    //       'Home',
    //       style: TextStyle(fontSize: 40),
    //     ));
    return Scaffold(
        body: FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<UserDataModel>;
                return ListView.builder(
                    itemCount: items == null ? 0 : items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        items[index].name.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child:
                                          Text(items[index].email.toString()),
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
            }));
  }

  Future<List<UserDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('lib/data/users.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => UserDataModel.fromJson(e)).toList();
  }
}
