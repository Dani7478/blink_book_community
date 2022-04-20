import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar_widget.dart';
import '../../Widgets/text_widget.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class EditDraftScreen extends StatefulWidget {

  final String book;
  final String author;
  final String category;
  final String image;
  final String summary;
  const EditDraftScreen(this.book, this.author, this.category, this.image, this.summary);
 // const EditDraftScreen({Key? key}) : super(key: key);

  @override
  _EditDraftScreenState createState() => _EditDraftScreenState();
}

int? id;
class _EditDraftScreenState extends State<EditDraftScreen> {
  late TextEditingController _summaryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetId();
  }
  @override
  Widget build(BuildContext context) {
    _summaryController=new TextEditingController(text: widget.summary);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Edit Draft'),
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
                      controller: _summaryController,
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
                      //  postDraft();
                        updateDraft();
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
                            "Update",
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


  updateDraft() async {
    String url = "http://${ip}/BlinkBookApi/api/Summary/UpdateDraftToSummary";
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
      SnackBarWidget(context, "Summary Draft is Successfully update", "Ok");
    } else {
      SnackBarWidget(context, "Something Went Wrong", "Ok");
      print(respose.body);
    }
  }

  postSummary() async {
    String url = "http://${ip}/BlinkBookApi/api/Summary/UpdateDraftToSummary";
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
