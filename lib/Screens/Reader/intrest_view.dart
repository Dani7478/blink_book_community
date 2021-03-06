import 'dart:convert';
import 'package:blink_book_community/Screens/Reader/pakage_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Widgets/snackbar_widget.dart';
import '../../main.dart';

class IntrestView extends StatefulWidget {
  const IntrestView({Key? key}) : super(key: key);

  @override
  State<IntrestView> createState() => _IntrestViewState();
}

List intrestList = [];
List<bool> listCheckBoxes = [];

class _IntrestViewState extends State<IntrestView> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Select Your Intrest'),
            Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: TextButton(
                  onPressed: () {
                    clearIntrest();
                    postIntrests();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PakageView()));
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.black),
                  )),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: intrestList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 20,
                      child: ListTile(
                        leading: const Icon(
                          Icons.arrow_circle_right_rounded,
                          size: 30,
                        ),
                        title: Text(
                          intrestList[index]['cname'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        trailing: Checkbox(
                            value: listCheckBoxes[index],
                            onChanged: (value) {
                              listCheckBoxes[index] = value!;
                              setState(() {});
                            }),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  getCategories() async {
    String address = "http://${ip}/BlinkBookApi/api/Category/getAllCategory";
    var respons = await http.get(Uri.parse(address));
    if (respons.statusCode == 200) {
      intrestList = json.decode(respons.body);
      for(int i=0; i< intrestList.length; i++) {
        print('Index : $i');
        listCheckBoxes.add(false);
      }
      setState(() {});
    }
  }

  postIntrests() async {
    String address = "http://$ip/BlinkBookApi/api/Reader/postIntrest";
    final prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('userid');
    for (int i = 0; i < listCheckBoxes.length; i++) {
      if (listCheckBoxes[i] == true) {
        var data = {
          'intrest1': intrestList[i]['cname'],
          'uid': userid.toString(),
        };
        var response = await http.post(Uri.parse(address), body: data);
         print(response.toString());
      }
    }
    SnackBarWidget(context, 'Intrest Added Successfully', 'OK');
  }

  clearIntrest() async {
    final prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('userid');
    String address =
        "http://$ip/BlinkBookApi/api/Reader/clearIntrest?userid=$userid";
    await http.get(Uri.parse(address));
  }
}
