import 'package:blink_book_community/Widgets/snackbar_widget.dart';
import 'package:blink_book_community/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeleteBooksScreen extends StatefulWidget {
  const DeleteBooksScreen({Key? key}) : super(key: key);

  @override
  State<DeleteBooksScreen> createState() => _DeleteBooksScreenState();
}

List BookList = [];
List copiedList = [];

class _DeleteBooksScreenState extends State<DeleteBooksScreen> {
  var _bookNameCntrl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('Delete Book'),
          actions: const [
            Icon(Icons.favorite),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
            Icon(Icons.more_vert),
          ],
          backgroundColor: Colors.purple,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextFormField(
                    onChanged: (value) {
                      refreshList(value);
                      setState(() {});
                    },
                    controller: _bookNameCntrl,
                    decoration: const InputDecoration(
                        hintText: "Search By Book or Authr ",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.book_online,
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                //color: Colors.pinkAccent,
                height: size.height - 110,
                child: showBooks(),
              ),
            ),
          ],
        ));
  }

  //___________________________GET ALL Books
  getAllBooks() async {
    String url = "http://${ip}/BlinkBookApi/api/book/getallbook";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      BookList = json.decode(response.body);
      copiedList = BookList;
    } else {
      BookList = [];
      //copiedList = BookList;
    }
    setState(() {});
  }

  //____________________________ON CHANGE
  refreshList(String newname) async {
    String url =
        "http://${ip}/BlinkBookApi/api/book/getByNameOrAuthor?name=${newname}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      BookList = json.decode(response.body);
      if (newname == null || newname == "") {
        BookList = copiedList;
      }
    } else {
      BookList = copiedList;
    }
    setState(() {});
  }

  //___________________________SHOW BOOKS
  showBooks() {
    return Container(
      child: ListView.builder(
          itemCount: BookList.length, // 3 5
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
                        base64Decode(BookList[index]["image"]),
                        //fit: BoxFit.fill,
                      ),
                    ),
                    title: Text(
                      BookList[index]["book1"],
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
                          BookList[index]["category"],
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
                          BookList[index]["author"],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                        onTap: () {
                          deletesnackBar(
                            BookList[index]["book1"].toString(),
                            BookList[index]["author"].toString(),
                          );
                        },
                        child: Icon(Icons.delete)),
                  ),
                ),
              ),
            );
          }),
    );
  }

  deletesnackBar(String bookname, String authorname) {
    final scaffold = ScaffoldMessenger.of(context);
    return scaffold.showSnackBar(
      SnackBar(
        //backgroundColor: Color(0xFF04128f),
        backgroundColor: Colors.grey,
        //duration: Duration(seconds: 1),
        content: const Text(
          "Are u want delete book",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: "Yes",
          onPressed: () async {
            var address =
                "http://${ip}/BlinkBookApi/api/book/deleteBook?bookname=$bookname&authorname=$authorname";
            var respose = await http.get(Uri.parse(address));
            if (respose.statusCode == 200) {
              SnackBarWidget(context, "${bookname} Deleted Successfully", "Ok");
              getAllBooks();
            } else {
              SnackBarWidget(context, "Something Went Wrong", "Ok");
            }
          },
          textColor: Colors.red,
        ),
      ),
    );
  }
}
