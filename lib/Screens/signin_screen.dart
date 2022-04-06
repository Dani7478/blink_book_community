import 'dart:convert';
import 'package:blink_book_community/Screens/Admin/admin_screen.dart';
import 'package:blink_book_community/Screens/Reader/reader_screen.dart';
import 'package:blink_book_community/Screens/signup_screen.dart';
import 'package:blink_book_community/Screens/Writer/writer_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailcontroler= TextEditingController();
  TextEditingController _passwordcontroler= TextEditingController();
  List? resultList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGNIN",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailPortion(),
            SizedBox(height: 30,),
            passwordPortion(),
            SizedBox(height: 30,),
            loginBtn(),
            SizedBox(height: 15,),
            simpleText(),
          ],
        ),
      ),
    );
  }
  emailPortion() {
   return Container(
      height: 55,
      width: 250,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child:  TextFormField(
          controller: _emailcontroler,
          decoration: InputDecoration(
              hintText: "Enter Email",
              border:InputBorder.none,
              prefixIcon: Icon(Icons.email),
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
          ),

        ),
      ),
    );
  }
  passwordPortion() {
    return Container(
      height: 55,
      width: 250,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child:  TextFormField(
          controller: _passwordcontroler,
          decoration: InputDecoration(
              hintText: "Enter Password",
              border:InputBorder.none,
              prefixIcon: Icon(Icons.lock),
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
          ),

        ),
      ),
    );
  }
  loginBtn() {
    return GestureDetector(
      onTap:() async{
        print("Signup Button Pressed");
        String email=_emailcontroler.text;
        String password=_passwordcontroler.text;

          String address="http://192.168.43.45/BlinkBookApi/api/user/checkuser?email=$email&password=$password";
          var response= await http.get(Uri.parse(address));
          if(response.statusCode==200)
          {
            resultList= json.decode(response.body);
            setState(() {});
            int? countList=resultList?.length;
          if(countList==0 )
            {
              print("Email or Password are Wrong");
            }
          if(countList==1)
            {
              String? role=resultList?[0]["role"].toString();
              print("$role");
              if(role?.toLowerCase()=="admin")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminScreen()));
                }
              if(role?.toLowerCase()=="writer")
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WriterScreen()));
              }

             // Navigator.push(context, MaterialPageRoute(builder: (context)=>ReaderScreen()));
            }
          }
        else
          {
            print("Something went Wrong");
          }


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
  simpleText() {
   return GestureDetector(
     onTap: ()
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
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