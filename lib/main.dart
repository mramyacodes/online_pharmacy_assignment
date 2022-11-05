import 'package:flutter/material.dart';
import 'package:online_pharmacy_assignment/pages/HomeScreen.dart';
import 'package:online_pharmacy_assignment/pages/LoginScreen.dart';
import 'package:online_pharmacy_assignment/pages/UnderConstruction_Doctor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //     providers: [
    //       // In this sample app, CatalogModel never changes, so a simple Provider
    //       // is sufficient.
    //       OrdersDataModel o;
    //       Provider(create: (context) => OrdersDataModel(o)),
    //       // CartModel is implemented as a ChangeNotifier, which calls for the use
    //       // of ChangeNotifierProvider. Moreover, CartModel depends
    //       // on CatalogModel, so a ProxyProvider is needed.
    //       ChangeNotifierProxyProvider<CatalogModel, CartModel>(
    //         create: (context) => CartModel(),
    //         update: (context, catalog, cart) {
    //           if (cart == null) throw ArgumentError.notNull('cart');
    //           cart.catalog = catalog;
    //           return cart;
    //         },
    //       ),
    //     ],
    return MaterialApp(
      title: 'Flutter Code Sample for Navigator',
      // MaterialApp contains our top-level Navigator
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoginScreen(),
        '/home': (BuildContext context) => HomeScreen(
              userid: 0,
            ),
        '/underconstructionDoctor': (BuildContext context) =>
            const UnderConstruction_Doctor(),
      },
    );
  }
}
