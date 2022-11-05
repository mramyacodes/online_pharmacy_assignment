// ignore: file_names
import 'package:flutter/material.dart';

class UnderConstruction_Lab extends StatefulWidget {
  const UnderConstruction_Lab({super.key});

  @override
  State<UnderConstruction_Lab> createState() => _UnderConstruction_LabState();
}

class _UnderConstruction_LabState extends State<UnderConstruction_Lab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Color.fromARGB(255, 238, 232, 232),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 48,
                      width: 48,
                      child: Image.asset('lib/icons/lab-test.png',
                          height: 50, color: Colors.redAccent),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Book Lab Appointment',
                        style: TextStyle(
                          fontSize: 24.0,
                          decorationThickness: 10,
                        ),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.construction_outlined,
              color: Colors.blueGrey,
              size: 90.0,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Page Under Construction',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ));
  }
}
