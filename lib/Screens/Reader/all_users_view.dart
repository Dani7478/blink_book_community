import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:blink_book_community/Widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

// ignore: must_be_immutable
class AllUsersView extends StatefulWidget {
  AllUsersView({Key? key, required this.summaryid}) : super(key: key);

  int summaryid;

  @override
  State<AllUsersView> createState() => _AllUsersViewState();
}

List allusersList = [];
List<String> emailsList = [];
int? senderid;

class _AllUsersViewState extends State<AllUsersView> {
  @override
  void initState() {
    super.initState();
    getAllUser();
    getUserId();
    getAllContacts();
  }

//___________________________________GET ALL USER

  getAllUser() async {
    String address = 'http://$ip/BlinkBookApi/api/shared/getUserslist';
    var result = await http.get(Uri.parse(address));
    if (result.statusCode == 200) {
      allusersList = json.decode(result.body);
      setState(() {});
    }
  }
  //____________________________________GET SEDER ID

  getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    senderid = prefs.getInt('userid');
  }

  //____________________________________GET ALL CONTACTS
  getAllContacts() async {
    List<Contact> contacts = await ContactsService.getContacts();

    print('contact list ${contacts.length}');
    for (int i = 0; i < contacts.length; i++) {
      if (contacts[i].emails!.isNotEmpty) {
        emailsList.add(contacts[i].emails!.first.value.toString());
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: userListView(),
    );
  }

  ///_______________________________________USER LIST
  userListView() {
    return allusersList.isEmpty || emailsList.isEmpty
        ? loading()
        : ListView.builder(
            itemCount: allusersList.length,
            itemBuilder: (context, index) {
              String name = allusersList[index]['fname'] +
                  ' ' +
                  allusersList[index]['lname'];
              String email = allusersList[index]['email'];
              int id = allusersList[index]['id'];

              bool isshow = false;
              for (int i = 0; i < emailsList.length; i++) {
                if (email.toLowerCase() == emailsList[i].toLowerCase()) {
                  isshow = true;
                }
              }

              return isshow == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )),
                        child: Center(
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 35,
                              ),
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              email,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: InkWell(
                              onLongPress: () async {
                                await submitData(id);
                              },
                              child: const Icon(
                                Icons.share,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ))
                  : Container();
            });
  }

  submitData(int reciever) async {
    String address = 'http://$ip/BlinkBookApi/api/shared/submitSummary';
    var data = {
      'senderid': senderid.toString(),
      'recieverid': reciever.toString(),
      'summaryid': widget.summaryid.toString()
    };
    var result = await http.post(Uri.parse(address), body: data);
    SnackBarWidget(context, result.body, 'OK');
  }

  //___________________________LOADING SPINNER
  loading() {
    return const Center(
      child: SpinKitCircle(
        //color: Colors.teal,
        color: Color.fromARGB(255, 15, 179, 124),
        size: 80.0,
      ),
    );
  }
}
