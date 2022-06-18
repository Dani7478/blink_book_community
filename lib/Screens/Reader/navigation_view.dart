import 'package:blink_book_community/Screens/Reader/reader_books.dart';
import 'package:flutter/material.dart';

import 'reader_summary_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

int index = 0;

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: index == 0 ? const ReaderSummaryView() : const ReaderBooksView(),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Row(children: [
          //___________________________________ONE

          Expanded(
            child: InkWell(
              onTap: () {
                index = 0;
                setState(() {});
              },
              child: Column(
                children: const [
                  Icon(
                    Icons.note,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Summary',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          //___________________________________Two

          Expanded(
            child: InkWell(
              onTap: () {
                index = 1;
                setState(() {});
              },
              child: Column(
                children: const [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Search',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          //___________________________________Three

          Expanded(
            child: InkWell(
              onTap: () {
                index = 2;
                setState(() {});
              },
              child: Column(
                children: const [
                  Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'My Books',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
