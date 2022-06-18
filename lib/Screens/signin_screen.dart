import 'dart:convert';
import 'package:blink_book_community/Screens/Admin/admin_screen.dart';
import 'package:blink_book_community/Screens/Editor/editor_screen.dart';
import 'package:blink_book_community/Screens/Reader/reader_screen.dart';
import 'package:blink_book_community/Screens/signup_screen.dart';
import 'package:blink_book_community/Screens/Writer/writer_screen.dart';
import 'package:blink_book_community/Widgets/snackbar_widget.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Publisher/publisher_screen.dart';
import 'Reader/intrest_view.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

int userid = 0;

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailcontroler = TextEditingController();
  TextEditingController _passwordcontroler = TextEditingController();
  List? resultList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text(
      //     "SIGNIN",
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      emailPortion(),
                      SizedBox(
                        height: 30,
                      ),
                      passwordPortion(),
                      SizedBox(
                        height: 30,
                      ),
                      loginBtn(),
                      SizedBox(
                        height: 15,
                      ),
                      simpleText(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  emailPortion() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
          border: Border.all(color: Colors.teal)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          controller: _emailcontroler,
          decoration: InputDecoration(
              hintText: "Enter Email",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.email),
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }

  passwordPortion() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
          border: Border.all(color: Colors.teal)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextFormField(
          controller: _passwordcontroler,
          decoration: InputDecoration(
              hintText: "Enter Password",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.lock),
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }

  loginBtn() {
    return GestureDetector(
      onTap: () async {
        // Obtain shared preferences.
        // final prefs = await SharedPreferences.getInstance();
        print("Signup Button Pressed");
        String email = _emailcontroler.text;
        String password = _passwordcontroler.text;

        String address =
            "http://${ip}/BlinkBookApi/api/user/checkuser?email=$email&password=$password";
        var response = await http.get(Uri.parse(address));
        if (response.statusCode == 200) {
          resultList = json.decode(response.body);
          setState(() {});
          int? countList = resultList?.length;
          if (countList == 0) {
            print("Email or Password are Wrong");
            SnackBarWidget(context, "Email or Password are Wrong", "OK");
          }
          if (countList == 1) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt('userid', resultList![0]["id"]);
            String? role = resultList?[0]["role"].toString();
            print("$role");
            SnackBarWidget(context,
                "${resultList?[0]["fname"]} is Successfully Login", "OK");
            if (role?.toLowerCase() == "admin") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()));
            }
            if (role?.toLowerCase() == "writer") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WriterScreen()));
            }
            if (role?.toLowerCase() == "editor") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditorScreen()));
            }
            if (role?.toLowerCase() == "publisher") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PublisherScreen()));
            }
            if (role?.toLowerCase() == "reader") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const IntrestView()));
            }

            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderScreen()));
          }
        } else {
          print("Something went Wrong");
          SnackBarWidget(context, "Something Went Wrong", "OK");
        }
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Text(
            "Signin",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  simpleText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupScreen()));
      },
      child: Text(
        "Dont have account? Signup",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
