// ignore: file_names
import 'package:flutter/material.dart';

class UnderConstruction_Doctor extends StatefulWidget {
  const UnderConstruction_Doctor({super.key});

  @override
  State<UnderConstruction_Doctor> createState() =>
      _UnderConstruction_DoctorState();
}

class _UnderConstruction_DoctorState extends State<UnderConstruction_Doctor> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.deepPurple[100]),
        // color: Color.fromARGB(77, 207, 207, 207),
        // alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          //children: const <Widget>[
          children: [
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 48,
                      child: Image.asset('lib/icons/doctor.png',
                          height: 50, color: Colors.redAccent),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Book Doctor Appointment',
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
              Icons.construction_rounded,
              color: Colors.black,
              size: 90.0,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Page Under Construction',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ));
  }
}
