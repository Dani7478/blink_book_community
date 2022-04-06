import 'package:blink_book_community/Screens/signin_screen.dart';
import 'package:blink_book_community/Screens/signup_screen.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logoContainer(),
            SizedBox(
              height: 20,
            ),
            headingText(),
            SizedBox(
              height: 20,
            ),
            signinButton(context),
            SizedBox(
              height: 20,
            ),
            signUpButton(context),
            
          ],
        ),
      ),
    );
  }

//____________________Functions
  signinButton(BuildContext context) {
    return GestureDetector(
      onTap:(){
        print("Signin Button Pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
        } ,
      child: Container(
        height: 50,
        width: 150,
        color: Colors.greenAccent,
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

  headingText() {
    return const Text(
      "Read What you Want, When you want",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  signUpButton(BuildContext context) {
    return GestureDetector(
      onTap:(){
        print("Signup Button Pressed");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
      } ,
      child: Container(
        height: 50,
        width: 150,
        color: Colors.greenAccent,
        child: const Center(
          child: Text(
            "Signup",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  logoContainer()
  {
   return Container(
      height: 150,
      width: 150,
      color: Colors.greenAccent,
     child: Center(
       child: Text(" B ",
         style: TextStyle(
           fontSize: 42,
           fontWeight: FontWeight.bold,
         ),
       ),
     ),
    );
  }
}
