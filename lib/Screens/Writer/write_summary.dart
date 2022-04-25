import 'dart:convert';
import 'package:blink_book_community/Function/get_user_id.dart';
import 'package:blink_book_community/Widgets/text_widget.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar_widget.dart';

class WriteSummaryScreen extends StatefulWidget {
  final String book;
  final String author;
  final String category;
  final String image;
  const WriteSummaryScreen(this.book, this.author, this.category, this.image);

  //const WriteSummaryScreen({Key? key}) : super(key: key);

  @override
  _WriteSummaryScreenState createState() => _WriteSummaryScreenState();
}

int id=0;

class _WriteSummaryScreenState extends State<WriteSummaryScreen> {
  final TextEditingController _summaryController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Write Summary'),
        actions: const [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.memory(
                        base64Decode(widget.image),
                        fit: BoxFit.cover,
                        //fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            "Book Name : ${widget.book} ", 18, Colors.black),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget("Category Name: ${widget.category} ", 18,
                            Colors.black),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget("Author Name : ${widget.author} ", 18,
                            Colors.black),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget("Summary writer: XYZ", 18, Colors.black),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      enableIMEPersonalizedLearning: true,
                      controller: _summaryController,
                        expands: true, 
                          maxLines: null,

                      decoration: InputDecoration(
                          hintText: "Write Summary for Book ${widget.book}",
                          border: InputBorder.none,
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        postDraft();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Draft",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                      await postSummary();

                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  postDraft() async {
    String url = "http://${ip}/BlinkBookApi/api/Summary/addSummaryforDarft";
    var data = {
      "book": widget.book,
      "author": widget.author,
      "category": widget.category,
      "summary1": _summaryController.text,
      "image": widget.image,
      "status": "0",
      "uid": id.toString(),
    };
    var respose = await http.post(Uri.parse(url), body: data);
    if (respose.statusCode == 200) {
      SnackBarWidget(context, "Summary saved in draft", "Ok");
    } else {
      SnackBarWidget(context, "Something Went Wrong", "Ok");
      print(respose.body);
    }
  }

  postSummary() async {
    String url = "http://${ip}/BlinkBookApi/api/Summary/addSummaryforDarft";
    var data = {
      "book": widget.book,
      "author": widget.author,
      "category": widget.category,
      "summary1": _summaryController.text,
      "image": widget.image,
      "status": "1",
      "uid": id.toString(),
    };
    var respose = await http.post(Uri.parse(url), body: data);
    if (respose.statusCode == 200) {
      SnackBarWidget(context, "Summary Successfully Added", "Ok");
    } else {
      SnackBarWidget(context, "Something Went Wrong", "Ok");
      print(respose.body);
    }
  }

  GetId() async {
   // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
   // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        id = prefs.getInt('userid')!;
    if (id != null) {
      print("id===== ${id}");
    } else {
      print("id===== null");
    }
  }
}
