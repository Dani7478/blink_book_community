import 'dart:convert';

import 'package:blink_book_community/Screens/Writer/edit_draft_screen.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({Key? key}) : super(key: key);

  @override
  _DraftScreenState createState() => _DraftScreenState();
}

List? _resultList = [];
int? id;
class _DraftScreenState extends State<DraftScreen> {
  //______________________Init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _resultList?.length == 0 ? loading() : showDraft2(),
    );
  }

  getAllData() async {
    String url = "http://${ip}/BlinkBookApi/api/Summary/getDraftByuser?id=${id.toString()}";
    print("id=====${id}");
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
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditDraftScreen(
                                _resultList![index]["book"].toString(),
                                _resultList![index]["author"].toString(),
                                _resultList![index]["category"].toString(),
                                _resultList![index]["image"].toString(),
                              _resultList![index]["summary1"].toString(),
                            )));
                  },
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


  //___________________________SHOW BOOKS
  showDraft2() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
          itemCount: _resultList?.length, // 3 5
          itemBuilder: (context, index) {
            return Container(
              height: 120,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Card(
                  //margin: EdgeInsets.all(20),
                  elevation: 20,
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
                        color: Colors.black,
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
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _resultList![index]["author"],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditDraftScreen(
                                  _resultList![index]["book1"].toString(),
                                  _resultList![index]["author"].toString(),
                                  _resultList![index]["category"].toString(),
                                  _resultList![index]["image"].toString(),
                                  _resultList![index]["summary1"].toString(),
                                )));
                      },
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
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
              ),
            );
          }),
    );
  }

  GetId() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    id = prefs.getInt('userid')!;
    if (id != null){
    await getAllData();
      print("id===== ${id}");
    } else {
      print("id===== null");
    }
  }
}
