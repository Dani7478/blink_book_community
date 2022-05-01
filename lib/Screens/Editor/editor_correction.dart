import 'dart:convert';
import 'package:blink_book_community/Function/get_user_id.dart';
import 'package:blink_book_community/Widgets/text_widget.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar_widget.dart';

class EditorCorrectionScreen extends StatefulWidget {
  final int summaryid;
  final String book;
  final String author;
  final String category;
  final String image;
  final String summary;
  final int userid;

  const EditorCorrectionScreen(this.summaryid, this.book, this.author,
      this.category, this.image, this.summary, this.userid);

  //const WriteSummaryScreen({Key? key}) : super(key: key);

  @override
  _EditorCorrectionScreenState createState() => _EditorCorrectionScreenState();
}

int id = 0;

class _EditorCorrectionScreenState extends State<EditorCorrectionScreen> {
  late TextEditingController _summaryController;

  TextEditingController _feedbackController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _summaryController = TextEditingController(text: widget.summary);
    //getUserName();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Editor FeedBack'),
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
                      height: 90,
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
                        TextWidget("Summary writer: pending", 18, Colors.black),
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
                      textAlign: TextAlign.justify,
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
                _feedBackContainer(),
                SizedBox(
                  height: 20,
                ),
                _ButtonRow(),
              ],
            ),
          )
        ],
      ),
    );
  }

  postData(String type) async {
    String url = "http://${ip}/BlinkBookApi/api/Editor/PostCorrection";
    var data = {
      "summaryid": widget.summaryid.toString(),
      "userid": widget.userid.toString(),
      "correctiontype": type.toString(),
      "paragraph": _feedbackController.text.toString(),
    };
    var respose = await http.post(Uri.parse(url), body: data);
    if (respose.statusCode == 200) {
      SnackBarWidget(context, "FeedBack is Added", "Ok");
    } else {
      SnackBarWidget(context, "Something Went Wrong", "Ok");
      print(respose.body);
    }
  }

  updateUserSummaryStatus(String type) async {
    //0 already as draf
    //1 aready as summary pending
    //2 means approve and wait for publish
    //3 means reject summary
    //4 for minor changes
    //5 for major changes
     late int status;
    if(type=='accept') { status=2; }
    if(type=='reject') { status=3; }
    if(type=='minor') { status=4; }
    if(type=='major') { status=5; }

    String url = "http://${ip}/BlinkBookApi/api/Editor/UpdateSummaryStatus?newid=${widget.summaryid}&newstatus=${status}";

    var respose = await http.get(Uri.parse(url));
    if (respose.statusCode == 200) {
      SnackBarWidget(context, "Sumamry posted for ${type} ", "Ok");
    } else {
      SnackBarWidget(context, "Something Went Wrong", "Ok");
      print(respose.body);
    }
  }

  _feedBackContainer() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextFormField(
          textAlign: TextAlign.justify,
          keyboardType: TextInputType.multiline,
          enableIMEPersonalizedLearning: true,
          controller: _feedbackController,
          expands: true,
          maxLines: null,
          decoration: const InputDecoration(
              hintText: "Write Correction  with feed back",
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }

  _ButtonRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //_______________Accept
      MaterialButton(
        onPressed: () async {
          await postData('accept');
          await updateUserSummaryStatus('accept');
        },
        child: Column(
          children: const [
            Icon(
              Icons.done,
              size: 20,
            ),
            SizedBox(
              height: 5,
            ),
            Text("Accept",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      //___________________Reject
      GestureDetector(
        onTap: () async{
          await postData('reject');
          await updateUserSummaryStatus('reject');
        },
        child: Column(
          children: const [
            Icon(
              Icons.cancel,
              size: 20,
            ),
            SizedBox(
              height: 3,
            ),
            Text("Reject",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
          ],
        ),
      ),

      //___________________Minor chnage
      GestureDetector(
        onTap: () async {
          await postData('minor');
          await updateUserSummaryStatus('minor');
        },
        child: Column(
          children: const [
            Icon(
              Icons.battery_alert,
              size: 20,
            ),
            SizedBox(
              height: 5,
            ),
            Text("Minor change",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
          ],
        ),
      ),

      //___________________Minor Changes
      GestureDetector(
        onTap: () async {
          await postData('major');
          await updateUserSummaryStatus('major');
        },
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Icon(
              Icons.battery_full,
              size: 20,
            ),
            const SizedBox(
              height: 5,
            ),
            Text("Major Change",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
          ],
        ),
      )
    ]);
  }
}
