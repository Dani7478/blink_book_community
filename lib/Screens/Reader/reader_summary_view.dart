import 'dart:convert';

import 'package:blink_book_community/Screens/Reader/reader_detail_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

class ReaderSummaryView extends StatefulWidget {
  const ReaderSummaryView({Key? key}) : super(key: key);

  @override
  State<ReaderSummaryView> createState() => _ReaderSummaryViewState();
}

String pakage = 'free';
List intrestList=[];
List listSummries=[];
int summaryLength = 0;

class _ReaderSummaryViewState extends State<ReaderSummaryView> {
  @override
  void initState() {
    super.initState();
    getIntrest();
    getPakage();
    getAllSummarries();
    getLength();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getIntrest() async {
    final prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('userid');
    String address =
        "http://$ip/BlinkBookApi/api/Reader/getuserIntrest?userid=$userid";
    var response = await http.get(Uri.parse(address));
    if (response.statusCode == 200) {
      List intrestList = json.decode(response.body);
      setState(() {});
      // ignore: avoid_print
      //  print(intrestList);
    }
  }

  getPakage() async {
    final prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('userid');
    String address =
        "http://$ip/BlinkBookApi/api/Reader/getUserPakage?userid=$userid";
    var response = await http.get(Uri.parse(address));
    if (response.statusCode == 200) {
      pakage = json.decode(response.body);
      setState(() {});
      // ignore: avoid_print
      print(pakage);
    }
  }

  getAllSummarries() async {
    String address = "http://$ip/BlinkBookApi/api/Reader/getAllPublishSummries";
    var response = await http.get(Uri.parse(address));
    if (response.statusCode == 200) {
      listSummries = json.decode(response.body);
      // ignore: avoid_print
      print(listSummries);
    }
    setState(() {});
  }

  getLength() {
    if (pakage.toLowerCase() == 'free') {
      summaryLength = 1;
    }
    if (pakage.toLowerCase() == 'basic') {
      summaryLength = 5;
    }
    if (pakage.toLowerCase() == 'premium') {
      summaryLength = 10;
    }
    if (pakage.toLowerCase() == 'platinium') {
      summaryLength = 15;
    }
    if (listSummries.length < summaryLength) {
      summaryLength = listSummries.length;
    }
    setState(() {});
    print('summary Length : $summaryLength');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: summaryLength == 0 || listSummries.length == 0
          ? loading()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListView.builder(
                  itemCount: summaryLength,
                  itemBuilder: (context, index) {
                    // ignore: avoid_print
                    print('index : $index');
                    String bookname = listSummries[index]['book'];
                    String author = listSummries[index]['author'];
                    String image = listSummries[index]['image'];
                    String category = listSummries[index]['category'];
                    String summary = listSummries[index]['summary1'];
                    return summaryCard(
                        bookname, image, category, author, summary);
                  }),
            ),
    );
  }

  summaryCard(String bookname, String image, String category, String author,
      String summary) {
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
                                1,
                                bookname,
                                author,
                                category,
                                image,
                                summary,
                                5)));
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
