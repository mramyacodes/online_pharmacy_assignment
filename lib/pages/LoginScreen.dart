import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_pharmacy_assignment/models/UserDataModel.dart';
import 'package:online_pharmacy_assignment/pages/HomeScreen.dart';
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<UserDataModel> allProducts = [];
  List<UserDataModel> filteredProducts = [];
  String mailId = '';

  initState() {
    super.initState();
    readJsonUserFile();
  }

  Future<void> readJsonUserFile() async {
    // WidgetsFlutterBinding.ensureInitialized();
    final String response = await rootBundle.loadString('lib/data/users.json');
    final productData = await json.decode(response);

    var list = productData["users"] as List<dynamic>;

    setState(() {
      allProducts = [];
      allProducts = list.map((e) => UserDataModel.fromJson(e)).toList();
      filteredProducts = allProducts;
    });
  }

  void _runFilter(String searchKeyword) {
    List<UserDataModel> results = [];
    readJsonUserFile();

    if (searchKeyword.isEmpty) {
      results = allProducts;
    } else {
      results = allProducts
          .where((element) =>
              element.email.toString().contains(searchKeyword.toLowerCase()))
          .toList();
    }
    filteredProducts = results;
  }

  _handleLogin() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Online Pharmacy'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign in',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'eMail',
                          hintText: 'Enter eMail Address',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()),
                      onChanged: (String value) {
                        mailId = value;
                      },
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Enter valid eMail address'
                            : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder()),
                      onChanged: (String value) {},
                      validator: (value) {
                        return value!.isEmpty ? 'Enter valid Password' : null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        _runFilter(mailId);

                        int useridparm = filteredProducts.isEmpty
                            ? 0
                            : filteredProducts[0].id!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userid: useridparm)),
                        );
                        //HomeScreen();
                      },
                      child: const Text('Login'),
                      color: Colors.teal,
                      textColor: Colors.white,
                      height: 50,
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
