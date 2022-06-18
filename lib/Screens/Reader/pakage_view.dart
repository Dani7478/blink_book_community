import 'dart:convert';

import 'package:blink_book_community/Screens/Reader/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Widgets/snackbar_widget.dart';
import '../../main.dart';

class PakageView extends StatefulWidget {
  const PakageView({Key? key}) : super(key: key);

  @override
  State<PakageView> createState() => _PakageViewState();
}

String pakageType = 'free';

class _PakageViewState extends State<PakageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Please Subribe Pakage'),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextButton(
                    onPressed: () {
                      clearPakage();
                      postPakage();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavigationView()));
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            //_____________________________________Free Pakage
            Expanded(
              child: Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 30,
                    ),
                    title: const Text(
                      'Free Pakage',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    subtitle: const Text(
                      'One Summary on Daily Bassis',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                          activeColor: Colors.orangeAccent,
                          value: 'free',
                          groupValue: pakageType,
                          onChanged: (value) {
                            pakageType = value.toString();
                            setState(() {});
                          }),
                    ),
                  ),
                ),
              ),
            ),

            //_____________________________________Basic Pakage
            Expanded(
              child: Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 30,
                    ),
                    title: const Text(
                      'Basic Pakage (Rs 2000)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    subtitle: const Text(
                      'Total 5 Summries Per Day',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                          activeColor: Colors.orangeAccent,
                          value: 'basic',
                          groupValue: pakageType,
                          onChanged: (value) {
                            pakageType = value.toString();
                            setState(() {});
                          }),
                    ),
                  ),
                ),
              ),
            ),

            //_____________________________________Premium Pakage
            Expanded(
              child: Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 30,
                    ),
                    title: const Text(
                      'Premium Pakage (Rs 5000)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    subtitle: const Text(
                      'Total 10 Summries Per Day',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                          activeColor: Colors.orangeAccent,
                          value: 'premium',
                          groupValue: pakageType,
                          onChanged: (value) {
                            pakageType = value.toString();
                            setState(() {});
                          }),
                    ),
                  ),
                ),
              ),
            ),

            //_____________________________________Platinium Pakage
            Expanded(
              child: Card(
                child: Center(
                  child: ListTile(
                    leading: const Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 30,
                    ),
                    title: const Text(
                      'Platinium Pakage (Rs 10000)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    subtitle: const Text(
                      'Total 15 Summries Per Day',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                          activeColor: Colors.orangeAccent,
                          value: 'platinium',
                          groupValue: pakageType,
                          onChanged: (value) {
                            pakageType = value.toString();
                            setState(() {});
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  postPakage() async {
    String address = "http://$ip/BlinkBookApi/api/Reader/postPakage";
    final prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('userid');
    var data = {'pakage1': pakageType, 'uid': userid.toString()};
    var response = await http.post(Uri.parse(address), body: data);
    var message = json.decode(response.body);

    SnackBarWidget(context, message, 'OK');
  }

  clearPakage() async {
    final prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('userid');
    String address =
        "http://$ip/BlinkBookApi/api/Reader/clearPakage?userid=$userid";
    await http.get(Uri.parse(address));
  }
}
