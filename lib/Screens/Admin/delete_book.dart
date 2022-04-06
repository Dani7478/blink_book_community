import 'package:blink_book_community/Widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
class DeleteBookScreen extends StatefulWidget {
  const DeleteBookScreen({Key? key}) : super(key: key);

  @override
  _DeleteBookScreenState createState() => _DeleteBookScreenState();
}

class _DeleteBookScreenState extends State<DeleteBookScreen> {

  TextEditingController _bookNameCntrl=new TextEditingController();
  TextEditingController _authorNameCntrl=new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Enter Book",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                 controller: _bookNameCntrl,
                  decoration: const InputDecoration(
                      hintText: "Enter Book Name",
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
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Enter Author",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  controller: _authorNameCntrl,
                  decoration: const InputDecoration(
                      hintText: "Enter Author Name",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person,
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
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: GestureDetector(
                onTap: () async{
                  await deleteBook();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteBook() async{
    String book=_bookNameCntrl.text;
    String author=_authorNameCntrl.text;
    var address="http://${ip}/BlinkBookApi/api/book/deleteBook?bookname=$book&authorname=$author";
  var respose= await http.get(Uri.parse(address));
  if(respose.statusCode==200)
    {
      SnackBarWidget(context, "${_bookNameCntrl.text} Deleted Successfully", "Ok");
    }
  else
    {
      SnackBarWidget(context, "Something Went Wrong", "Ok");
    }
  }
}
