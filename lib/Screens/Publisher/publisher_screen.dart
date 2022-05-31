import 'package:blink_book_community/Screens/Publisher/publisher_detail.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PublisherScreen extends StatefulWidget {
  const PublisherScreen({Key? key}) : super(key: key);

  @override
  State<PublisherScreen> createState() => _PublisherScreenState();
}

List? acceptedSummries;

class _PublisherScreenState extends State<PublisherScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllAcceptedSummries();
  }

//___________________________GET ALL Summary
  getAllAcceptedSummries() async {
    String url = "http://${ip}/BlinkBookApi/api/Publisher/GetAllAcceptedSummries";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      acceptedSummries = json.decode(response.body);
    } else {
      acceptedSummries = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            PopupMenuButton<String>(
                onSelected: (value) {},
                itemBuilder: (BuildContext context) {
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DraftScreen()));
                            },
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            "Logout",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      // value: "notifications",
                    ),
                  ];
                }),
          ],
          title: Text("Publisher Screen"),
          centerTitle: false,
          backgroundColor: Colors.purple,
        ),
      ),
      body: acceptedSummries == null
          ? loading()
          : ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 55,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  onChanged: (value) {
                    searchPortion(value.toString());
                    setState(() {});
                  },
                  //  controller: lastNameCnt,
                  decoration: const InputDecoration(
                      hintText: "Search Book",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person),
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height-140,
              // color: Colors.pink,
              child: showSummary(),
            ),
          )
        ],
      ),
    );
  }

  //_______________For Search Portion
  searchPortion(String bookname) async {
    // String url =
    //     "http://${ip}/BlinkBookApi/api/book/getBookByName?bookname=${bookname}";
    // var response = await http.get(Uri.parse(url));
    // if (response.statusCode == 200) {
    //   BookList = json.decode(response.body);
    // } else {
    //   BookList = null;
    // }
    // setState(() {});
  }

  showSummary() {
    return ListView.builder(
        itemCount: acceptedSummries!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Card(
              elevation: 20,
              child: Container(
                height: 100,
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Image.memory(
                            base64Decode(acceptedSummries![index]["image"]),
                            //fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(
                          acceptedSummries![index]['book'],
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
                              acceptedSummries![index]['author'],
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
                              acceptedSummries![index]['category'],
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
                                    builder: (context) => PublisherDetail(
                                      acceptedSummries![index]["id"],
                                      acceptedSummries![index]["book"],
                                      acceptedSummries![index]["author"],
                                      acceptedSummries![index]["category"],
                                      acceptedSummries![index]["image"],
                                      acceptedSummries![index]["summary1"],
                                      acceptedSummries![index]["uid"],

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
                                "View Detail",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        });
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
}
