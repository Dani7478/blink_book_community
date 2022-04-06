import 'package:flutter/material.dart';

class ShowEmployee extends StatelessWidget {
  const ShowEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        child: Center(child: Text("Show Employee",
          style: TextStyle(
            fontSize: 28,
          ),
        )),
      ),
    );
  }
}
