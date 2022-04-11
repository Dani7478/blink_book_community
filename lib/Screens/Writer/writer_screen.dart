import 'dart:convert';
import 'package:blink_book_community/Screens/Writer/draft_screen.dart';
import 'package:blink_book_community/Screens/Writer/write_summary.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WriterScreen extends StatefulWidget {
  const WriterScreen({Key? key}) : super(key: key);

  @override
  _WriterScreenState createState() => _WriterScreenState();
}

class _WriterScreenState extends State<WriterScreen> {

  List? BookList=null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBooks();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: () {
          //       updateAttendance();
          //     },
          //     icon: Icon(
          //       Icons.refresh,
          //       size: 35.0,
          //     ),
          //   ),
          // ],
          actions: [

            PopupMenuButton<String>(onSelected: (value) {

            }, itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.drafts,
                          color: Colors.purple,
                        ),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DraftScreen()));
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        "Drafts",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                 // value: "notifications",
                ),
              ];
            }),
          ],
          title: Text("Writer Screen"),
          centerTitle: false,
          backgroundColor: Colors.purple,
        ),
      ),
      body:BookList==null?
      loading() :
      showBooks(),
    );
  }

  //___________________________GET ALL BOOKS
  getAllBooks() async
  {
    String url="http://${ip}/BlinkBookApi/api/book/getallbook";
    var response=await http.get(Uri.parse(url));
    if(response.statusCode==200)
      {
        BookList=json.decode(response.body);
      }
    else
      {
        BookList=null;
      }
    setState(() {});
  }
  //___________________________LOADING SPINNER
  loading()
  {
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
  showBooks()
  {
    return ListView.builder(
      itemCount: BookList?.length, // 3 5
        itemBuilder: (context, index){
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
                  base64Decode(BookList![index]["image"]),
                  //fit: BoxFit.fill,
                ),
              ),
              title:Text( BookList![index]["book1"],
                style: const TextStyle(
                color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
              ),),
              subtitle:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( BookList![index]["category"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),),
                  SizedBox(height: 5,),
                  Text( BookList![index]["author"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                ],
              ),
              trailing:  GestureDetector(
                onTap:() async{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    WriteSummaryScreen(BookList![index]["book1"], BookList![index]["author"], BookList![index]["category"], BookList![index]["image"])
                  ));
                } ,
                child: Container(
                  height: 30,
                  width: 80,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10),
                 ),
                  child: const Center(
                    child: Text(
                      "Write Summary",
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
