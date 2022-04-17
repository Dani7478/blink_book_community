import 'dart:convert';

import 'package:blink_book_community/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class DraftScreen extends StatefulWidget {
  const DraftScreen({Key? key}) : super(key: key);

  @override
  _DraftScreenState createState() => _DraftScreenState();
}

List? _resultList = [];

class _DraftScreenState extends State<DraftScreen> {
  //______________________Init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _resultList?.length == 0 ? loading() : showDraft(),
    );
  }

  getAllData() async {
    String url = "http://${ip}/BlinkBookApi/api/Summary/getDraftByuser?id=1";
    var respons = await http.get(Uri.parse(url));
    if (respons.statusCode == 200) {
      _resultList = json.decode(respons.body);
      setState(() {});
    } else {
      print("Something went Wrong");
    }
  }

  //___________________________LOADING SPINNER
  loading() {
    return Container(
      child: const Center(
        child: SpinKitCircle(
          //color: Colors.teal,
          color: Color(0xFF0f65b3),
          size: 80.0,
        ),
      ),
    );
  }

  //___________________________SHOW BOOKS
  showDraft() {
    return ListView.builder(
        itemCount: _resultList?.length, // 3 5
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Image.memory(
                    base64Decode(_resultList![index]["image"]),
                    //fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  _resultList![index]["book"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _resultList![index]["category"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _resultList![index]["author"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () async {},
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Edit Summary",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
