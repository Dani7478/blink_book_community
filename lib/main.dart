import 'package:blink_book_community/Screens/Admin/admin_screen.dart';
import 'package:blink_book_community/Screens/Admin/add_book.dart';
import 'package:blink_book_community/Screens/Admin/category.dart';
import 'package:blink_book_community/Screens/Reader/reader_screen.dart';
import 'package:blink_book_community/Screens/Writer/writer_screen.dart';
import 'package:blink_book_community/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/Admin/delete_book.dart';
import 'Screens/Admin/delete_books.dart';
import 'Screens/Writer/draft_screen.dart';
import 'Screens/signin_screen.dart';
import 'Screens/test_screen.dart';
import 'Task_1/regester_employee.dart';
import 'Task_1/show_employee.dart';

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
      home: SignInScreen(),
    );
  }
}
