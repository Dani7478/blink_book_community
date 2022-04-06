import 'package:blink_book_community/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

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


class _WriteSummaryScreenState extends State<WriteSummaryScreen> {
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
                    ),
                    SizedBox(width: 20,),
                    Column(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget("Book Name : ", 18, Colors.black),
                        const SizedBox(height: 5,),
                        TextWidget("Book Name : Book 1 ", 18, Colors.black),
                        const SizedBox(height: 5,),
                        TextWidget("Book Name : Book 1 ", 18, Colors.black),
                        const SizedBox(height: 5,),
                        TextWidget("Book Name : Book 1 ", 18, Colors.black),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 GestureDetector(
                      onTap:() async{
                      } ,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap:() async{
                      } ,
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
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
