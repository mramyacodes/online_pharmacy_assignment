import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:online_pharmacy_assignment/models/OrdersDetail.dart';
import 'package:online_pharmacy_assignment/pages/MainScreen.dart';
import 'package:online_pharmacy_assignment/pages/OrdersDashboard.dart';
import 'package:online_pharmacy_assignment/pages/OrdersScreen.dart';
import 'package:online_pharmacy_assignment/pages/ShoppingCart.dart';
import 'package:online_pharmacy_assignment/pages/UnderConstruction_Lab.dart';
import 'package:online_pharmacy_assignment/pages/OrdersScreen.dart';

import 'UnderConstruction_Doctor.dart';

class HomeScreen extends StatefulWidget {
  int userid;

  HomeScreen({required this.userid});

  @override
  _HomeScreenState createState() => _HomeScreenState(userid: userid);
}

class _HomeScreenState extends State<HomeScreen> {
  int userid;
  int parm = 0;
  _HomeScreenState({required this.userid}) {
    parm = userid;
  }

  static OrdersDataModel ord = new OrdersDataModel(0, 0, 0, 0, '', []);
  final List pages = [
    // Content for Home tab
    MainScreen(userid: 0),
    UnderConstruction_Doctor(),
    UnderConstruction_Lab(),
    OrdersDashboard(
      order: ord,
      userId: 0,
    )
    // ShoppingCart()
  ];

  // final List pages = [MainScreen(), UnderConstruction(), ShoppingCart()];

  int _selectedIndex = 0;

  bool ishomescreen() {
    if (_selectedIndex == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Pharmacy"),
      ),
      //       body: pages[_selectedIndex],
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: 0,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              // called when one tab is selected
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // bottom tab items
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Doctor'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.device_thermostat), label: 'Lab'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: 'Medicines')
                ])
          : null,

      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedIndex: _selectedIndex,
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Book Doctor Appointment')),
                NavigationRailDestination(
                    icon: Icon(Icons.device_thermostat),
                    label: Text('Book Lab Appointment')),
                NavigationRailDestination(
                    icon: Icon(Icons.shopping_cart),
                    label: Text('Order Medicines')),
              ],

              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(
                color: Colors.teal,
              ),

              unselectedLabelTextStyle: const TextStyle(),
              // Called when one tab is selected
              leading: Column(
                children: const [
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          // ishomescreen()
          //     ? Expanded(
          //         child: MainScreen(
          //         userid: userid,
          //       ))
          //     : Expanded(child: pages[_selectedIndex])
          _selectedIndex == 0
              ? Expanded(
                  child: MainScreen(
                  userid: userid,
                ))
              : _selectedIndex == 1
                  ? Expanded(child: pages[_selectedIndex])
                  : _selectedIndex == 2
                      ? Expanded(child: pages[_selectedIndex])
                      : Expanded(
                          child: OrdersDashboard(
                          order: ord,
                          userId: userid,
                        ))
        ],
      ),
    );
  }
}
