import 'package:blink_book_community/Screens/Reader/favourite_summries.dart';
import 'package:flutter/material.dart';

class ReaderBooksView extends StatelessWidget {
  const ReaderBooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showCard(context, 'Favourite Books', 'All my favourite Books',
                Icons.favorite_outlined, 1),
            showCard(
              context,
              'See Shared Books',
              'All Friends Share Books',
              Icons.share,
              2,
            ),
          ],
        ),
      ),
    );
  }

  showCard(BuildContext context, String title, String subtitle, IconData icon,
      int type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Center(
          child: ListTile(
            leading: Icon(icon, color: Colors.black, size: 30),
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54),
            ),
            trailing: InkWell(
                onTap: () {
                 if(type==1) {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => const FavouriteSummriesView()));
                 }
                },
                child: const Icon(Icons.arrow_forward_ios,
                    color: Colors.black, size: 40)),
          ),
        ),
      ),
    );
  }
}
