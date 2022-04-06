import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 70, left: 50),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 25,),
            const Text("Enter Employee Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 300,
              color: Colors.redAccent,
              child: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Name",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Enter Employee Age",
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 300,
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Age",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),),

                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Enter Employee Number",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 300,
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Number",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),),

                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Enter Employee Department",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 300,
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Department",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),),

                ),

              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Enter Employee Salary",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 300,
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Your Salary",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),),

                ),

              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Row(
                children: [
                  GestureDetector(
                    onTap:(){ print("Save Button Pressed"); },
                    child:   Container(
                      height: 40,
                      width: 100,
                      color: Colors.redAccent,
                      child: Center(child: Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
                    ),
                  ),
                  SizedBox(width: 25),
                  GestureDetector(
                    onTap: (){print("Cancel Button Pressed");},
                    child:  Container(
                      height: 40,
                      width: 100,
                      color: Colors.redAccent,
                      child: Center(child: Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),

                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
