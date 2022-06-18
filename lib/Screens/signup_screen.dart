import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var languageList = ["Select Language", "English", "Urdu", "Arabic"];
  String languageSelected = "Select Language";

  var countryList = ["Select Country", "Pakistan", "India", "China", "Iran"];
  String countrySelected = "Select Country";

  var roleList = [
    "Select Role",
    "Admin",
    "Writer",
    "Reader",
    "Publisher",
    "Editor"
  ];
  String roleSelected = "Select Role";

  var genderList = ["Select Gender", "Male", "Female"];
  String genderSelected = "Select Gender";

  TextEditingController firstNameCnt = new TextEditingController();
  TextEditingController lastNameCnt = new TextEditingController();
  TextEditingController emailCnt = new TextEditingController();
  TextEditingController passwordCnt = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "SIGNUP",
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 55,
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Center(
                      child: Text(
                    "Registration",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextFormField(
                    controller: firstNameCnt,
                    decoration: InputDecoration(
                        hintText: "Enter First Name",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextFormField(
                    controller: lastNameCnt,
                    decoration: InputDecoration(
                        hintText: "Enter Second Name",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextFormField(
                    controller: emailCnt,
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextFormField(
                    controller: passwordCnt,
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: DropdownButton(
                    value: languageSelected,
                    items: languageList.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ));
                    }).toList(),
                    onChanged: (String? value) {
                      languageSelected = value!;
                      setState(() {});
                      print(languageSelected);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: DropdownButton(
                    value: countrySelected,
                    items: countryList.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ));
                    }).toList(),
                    onChanged: (String? value) {
                      countrySelected = value!;
                      setState(() {});
                      print(countrySelected);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: DropdownButton(
                    value: roleSelected,
                    items: roleList.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ));
                    }).toList(),
                    onChanged: (String? value) {
                      roleSelected = value!;
                      setState(() {});
                      print(roleSelected);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    border: Border.all(color: Colors.teal)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: DropdownButton(
                    value: genderSelected,
                    items: genderList.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ));
                    }).toList(),
                    onChanged: (String? value) {
                      genderSelected = value!;
                      setState(() {});
                      print(genderSelected);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  print("Signup Button Pressed");
                  String fname = firstNameCnt.text;
                  String lname = lastNameCnt.text;
                  String email = emailCnt.text;
                  String password = passwordCnt.text;
                  print("$fname, $lname, $email, $password");
                  String address =
                      "http://192.168.43.45/BlinkBookApi/api/user/adduser";
                  var data = {
                    "fname": firstNameCnt.text,
                    "lname": lastNameCnt.text,
                    "email": emailCnt.text,
                    "password": passwordCnt.text,
                    "language": languageSelected,
                    "country": countrySelected,
                    "role": roleSelected,
                    "gender": genderSelected
                  };
                  var respons = await http.post(Uri.parse(address), body: data);
                  if (respons.statusCode == 200) {
                    print("Data Saved");
                  } else {
                    print("Something Went Wrong");
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  color: Colors.teal,
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
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Already Have an Account? Signup",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
