import 'package:blink_book_community/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({Key? key}) : super(key: key);

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  var CategoryList = [
    "Islamic",
    "Science",
    "Novels",
    "History",
    "Sports",
    "Education",
    "Social",
    "Technology",
    "Cooking"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Blink'),
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
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(CategoryList.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextWidget(CategoryList[index], 18.0, Colors.white),
              ),
            ),
          );
        }),
      ),
    );
  }
}
