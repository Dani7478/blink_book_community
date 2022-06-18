import 'dart:async';

import 'package:blink_book_community/Screens/signin_screen.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'images/mainlogo.png',
              height: 250,
              width: 250,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Loading...',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.green,
                  strokeWidth: 3,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
