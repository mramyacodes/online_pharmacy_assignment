// ignore: file_names
import 'package:flutter/material.dart';

class UnderConstruction extends StatefulWidget {
  const UnderConstruction({super.key});

  @override
  State<UnderConstruction> createState() => _UnderConstructionState();
}

class _UnderConstructionState extends State<UnderConstruction> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purple.shade100,
        alignment: Alignment.center,
        child: const Text(
          'Book Doctor Appointment',
          style: TextStyle(fontSize: 40),
        ));
  }
}
