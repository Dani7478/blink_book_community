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

class ModifySummaryScreen extends StatefulWidget {
  final int summaryid;
  //final String book;
  //final String author;
  //final String category;
  //final String image;
  final String summary;
  final String changes;

  const ModifySummaryScreen(this.summaryid, this.summary, this.changes);

  //const WriteSummaryScreen({Key? key}) : super(key: key);

  @override
  _ModifySummaryScreenState createState() => _ModifySummaryScreenState();
}

int id = 0;

class _ModifySummaryScreenState extends State<ModifySummaryScreen> {
  late TextEditingController _summaryController;
 //late TextEditingController _feedbackController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _summaryController = TextEditingController(text: widget.summary);
    //_feedbackController = TextEditingController(text: widget.changes);
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
                      decoration: const InputDecoration(
                          //  hintText: "Write Summary for Book ${widget.book}",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _feedBackContainer(),
                const SizedBox(
                  height: 20,
                ),
                Button()
                // _ButtonRow(),
              ],
            ),
          )
        ],
      ),
    );
  }

  postData(String type) async {
    // String url = "http://${ip}/BlinkBookApi/api/Editor/PostCorrection";
    // var data = {
    //   "summaryid": widget.summaryid.toString(),
    //   "userid": widget.userid.toString(),
    //   "correctiontype": type.toString(),
    //   "paragraph": _feedbackController.text.toString(),
    // };
    // var respose = await http.post(Uri.parse(url), body: data);
    // if (respose.statusCode == 200) {
    //   SnackBarWidget(context, "FeedBack is Added", "Ok");
    // } else {
    //   SnackBarWidget(context, "Something Went Wrong", "Ok");
    //   print(respose.body);
    // }
  }

  updateUserSummaryStatus(String type) async {
    //0 already as draf
    //1 aready as summary pending
    //2 means approve and wait for publish
    //3 means reject summary
    //4 for minor changes
    //5 for major changes
    late int status;
    if (type == 'accept') {
      status = 2;
    }
    if (type == 'reject') {
      status = 3;
    }
    if (type == 'minor') {
      status = 4;
    }
    if (type == 'major') {
      status = 5;
    }

    String url =
        "http://${ip}/BlinkBookApi/api/Editor/UpdateSummaryStatus?newid=${widget.summaryid}&newstatus=${status}";

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
          child: Text(widget.changes,
              style: const TextStyle(
                backgroundColor: Colors.yellowAccent,
                fontSize: 15,
              ))
          // TextFormField(

          //   textAlign: TextAlign.justify,
          //   keyboardType: TextInputType.multiline,
          //   enableIMEPersonalizedLearning: true,
          //   controller: _feedbackController,
          //   expands: true,
          //   maxLines: null,
          //   decoration: const InputDecoration(
          //       hintText: "Write Correction  with feed back",
          //       border: InputBorder.none,
          //       hintStyle: TextStyle(
          //         color: Colors.white,
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //       )),
          // ),
          ),
    );
  }

  Button() {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.teal,
      child: MaterialButton(
        onPressed: () {
           updateSummaryAfterCorrection();
        },
        child: const Center(
            child: Text("Modify Done",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ))),
      ),
    );
  }

  updateSummaryAfterCorrection() async {
   String summary= _summaryController.text;
    String url = 'http://${ip}/BlinkBookApi/api/Summary/UpdateAfterCorrection?summaryid=${widget.summaryid}&summary=${summary}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      SnackBarWidget(context, 'Again Submited Modify Summary', 'Ok');
        Navigator.pop(context);
      GetId();
      setState((){});
    }else{
      SnackBarWidget(context, 'Something Went Wrong', 'Ok');
    }
  }
}
