import 'dart:convert';
import 'package:blink_book_community/Function/get_user_id.dart';
import 'package:blink_book_community/Screens/Publisher/publisher_screen.dart';
import 'package:blink_book_community/Widgets/text_widget.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/snackbar_widget.dart';

class ReaderSummaryDetailView extends StatefulWidget {
  final int summaryid;
  final String book;
  final String author;
  final String category;
  final String image;
  final String summary;
  final int userid;
  final bool isShow;

  const ReaderSummaryDetailView(this.summaryid, this.book, this.author,
      this.category, this.image, this.summary, this.userid, this.isShow);

  //const WriteSummaryScreen({Key? key}) : super(key: key);

  @override
  _ReaderSummaryDetailViewState createState() =>
      _ReaderSummaryDetailViewState();
}

int id = 0;
String user='Pending';

class _ReaderSummaryDetailViewState extends State<ReaderSummaryDetailView> {
  late TextEditingController _summaryController;

  TextEditingController _feedbackController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    _summaryController = TextEditingController(text: widget.summary);
    //getUserName();
  }
  getUserName() async {
    int uid=widget.userid;
    print(uid);
    String address = "http://$ip/BlinkBookApi/api/Reader/getSummaryWriter?uid=$uid";
    var response1 = await http.get(Uri.parse(address));
    user=json.decode(response1.body).toString();
    setState(() {
      print(user);
    });
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
                        TextWidget("Summary writer: $user", 18, Colors.black),
                      ],
                    )
                  ],
                ),
                const SizedBox(
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
                      enabled: false,
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
             widget.isShow==true ? _ButtonRow(widget.summaryid) : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _ButtonRow(int summaryid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: (){
              submitFavourite();
            },
            child: Row(
              children: const [
                Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Like',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
              ],
            ),
          ),
          // Row(
          //   children: const [
          //     Icon(
          //       Icons.comment,
          //       color: Colors.black,
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Text('Comment',
          //         style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w800,
          //             color: Colors.black)),
          //   ],
          // ),
          Row(
            children: const [
              Icon(
                Icons.share,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Share',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.black)),
            ],
          )
        ],
      ),
    );
  }
  submitFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('userid');
    String address =
        "http://$ip/BlinkBookApi/api/Reader/postFavourite";
    var data ={
      'summarryid':widget.summaryid.toString(),
      'uid':userid.toString(),
    };
    var result= await http.post(Uri.parse(address), body: data);
    String msg=json.decode(result.body);
    SnackBarWidget(context, msg, 'OK');
  }
}
