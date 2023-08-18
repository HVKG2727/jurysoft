
import 'package:flutter/material.dart';
import 'package:jurysoft/provider/ProviderPage.dart';
import 'package:jurysoft/screens/Home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      title: 'eCommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductGrid(),
    );
  }
}






