import 'package:blink_book_community/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

String ip = "192.168.43.45";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blink Book Community',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashView(),
    );
  }
}
