import 'package:calculadora_imc_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.light,
        //   primary: Colors.deepOrange,
        //   onPrimary: Colors.black,
        //   secondary: Colors.white,
        //   onSecondary: Colors.black,
        //   error: Colors.red,
        //   onError: Colors.black,
        //   background: Colors.white,
        //   onBackground: Colors.deepOrange,
        //   surface: Colors.white,
        //   onSurface: Colors.deepOrange,
        // ),
      ),
      home: const HomePage(),
    );
  }
}
