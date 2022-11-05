import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pharmacy_assignment/models/UserDataModel.dart';

import '../models/OrdersDetail.dart';

class OrdersDashboard extends StatefulWidget {
  final UserDataModel users;
  final OrdersDataModel orders;
  OrdersDashboard({required this.users, required this.orders});

  @override
  State<OrdersDashboard> createState() =>
      _OrdersDashboardState(users: users, orders: orders);
}

class _OrdersDashboardState extends State<OrdersDashboard> {
  final UserDataModel users;
  final OrdersDataModel orders;
  _OrdersDashboardState({required this.users, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
