// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:blink_book_community/Screens/Reader/reader_detail_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class SharedSummries extends StatefulWidget {
  const SharedSummries({Key? key}) : super(key: key);

  @override
  State<SharedSummries> createState() => _SharedSummriesState();
}

List listSummries = [];

class _SharedSummriesState extends State<SharedSummries> {
  int? recieverid;
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    recieverid = prefs.getInt('userid');
    getAllSummarries();
  }

  getAllSummarries() async {
    String address =
        "http://$ip/BlinkBookApi/api/shared/getSharedSummries?recieverid=$recieverid";
    var response = await http.get(Uri.parse(address));
    if (response.statusCode == 200) {
      listSummries = json.decode(response.body);
      print('total list ${listSummries.length}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView.builder(
            itemCount: listSummries.length,
            itemBuilder: (context, index) {
              // ignore: avoid_print

              int summid = listSummries[index]['id'];
              String bookname = listSummries[index]['book'];
              String author = listSummries[index]['author'];
              String image = listSummries[index]['image'];
              String category = listSummries[index]['category']; //coockoing
              String summary = listSummries[index]['summary1'];
              int userid = listSummries[index]['uid'];
              bool ishow = false;

              return summaryCard(
                  summid, bookname, image, category, author, summary, userid);
            }),
      ),
    );
  }

  summaryCard(int summid, String bookname, String image, String category,
      String author, String summary, int userid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        )),
        child: Card(
          color: Colors.tealAccent,
          child: Center(
            child: ListTile(
              leading: Container(
                height: 80,
                //   width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Image.memory(
                  base64Decode(image),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                bookname,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                author,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 36, 35, 35)),
              ),
              trailing: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReaderSummaryDetailView(
                                summid,
                                bookname,
                                author,
                                category,
                                image,
                                summary,
                                userid,
                                true)));
                  },
                  child: const Text('Read',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //___________________________LOADING SPINNER
  loading() {
    return const Center(
      child: SpinKitCircle(
        //color: Colors.teal,
        color: Color.fromARGB(255, 15, 179, 124),
        size: 80.0,
      ),
    );
  }
}
