import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:blink_book_community/Widgets/snackbar_widget.dart';
import 'package:blink_book_community/Widgets/text_widget.dart';

import '../../main.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

int countTxtField = 1;

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _bookNameCntrl = TextEditingController();
  final TextEditingController _authorNameCntrl = TextEditingController();
  final TextEditingController _authorNameCntr2 = TextEditingController();
  final TextEditingController _authorNameCntr3 = TextEditingController();

  File? imageFile;
  String? imageData;

  List? resultList;
  List<String>? _categoryList = [];
  String? _selectCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Add New Book'),
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView(
          children: [
            const Text(
              "Select Category",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: DropdownButton(
                  alignment: Alignment.center,
                  dropdownColor: Colors.redAccent,
                  value: _selectCategory,
                  items: _categoryList?.map((String items) {
                    return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    _selectCategory = value.toString();
                    setState(() {});
                    print(_selectCategory);
                  },
                ),
              ),
            ),
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
              height: 15,
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
                padding: const EdgeInsets.only(left: 8, right: 12),
                child: TextFormField(
                  controller: _authorNameCntrl,
                  decoration: InputDecoration(
                      hintText: "Enter Author Name 1",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      suffix: countTxtField == 1
                          ? GestureDetector(
                              onTap: () {
                                countTxtField = countTxtField + 1;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.add,
                                // size: 100,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              Icons.add,
                              // size: 100,
                              color: Colors.redAccent,
                            ),
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            countTxtField >= 2
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(
                    height: 0,
                  ),
            countTxtField >= 2
                ? Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 12),
                      child: TextFormField(
                        controller: _authorNameCntr2,
                        decoration: InputDecoration(
                            hintText: "Enter Author Name 2",
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            suffix: countTxtField == 2
                                ? GestureDetector(
                                    onTap: () {
                                      countTxtField = countTxtField + 1;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.add,
                                      // size: 100,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(Icons.add,
                                    // size: 100,
                                    color: Colors.redAccent),
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                : Container(),
            countTxtField >= 3
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(
                    height: 0,
                  ),
            countTxtField >= 3
                ? Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 12),
                      child: TextFormField(
                        controller: _authorNameCntr3,
                        decoration: InputDecoration(
                            hintText: "Enter Author Name 3",
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
                  )
                : Container(),
            const SizedBox(
              height: 15,
            ),
            imageData != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90),
                    child: Container(
                        height: 130,
                        //width: 100,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.memory(
                          base64Decode(imageData!),
                          //fit: BoxFit.fill,
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 90, right: 90),
                    child: Container(
                      height: 130,
                      //width: 100,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: GestureDetector(
                onTap: () {
                  _imgFromGallery();
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Browse",
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
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: GestureDetector(
                onTap: () async {
                  await postData();
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Add",
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

  //_______________________GET DATA FOR DROP DOWN LIST
  getData() async {
    String address = "http://${ip}/BlinkBookApi/api/Category/getAllCategory";
    var respons = await http.get(Uri.parse(address));
    if (respons.statusCode == 200) {
      resultList = json.decode(respons.body);
      setState(() {});
      int? count = resultList?.length; //2
      _selectCategory = resultList![0]["cname"];
      for (int i = 0; i < count!; i++) {
        _categoryList?.add(resultList![i]["cname"].toString());
        print(resultList![i]["cname"]);
      }
      setState(() {});
    }
  }

  //________________________FOR SAVE BOOK
  postData() async {
    List<String> contrlrList = [
      _authorNameCntrl.text,
      _authorNameCntr2.text,
      _authorNameCntr3.text
    ];
    String address = "http://192.168.43.45/BlinkBookApi/api/book/addBook";
    for (int i = 0; i < countTxtField; i++) {
      var data = {
        "category": _selectCategory,
        "book1": _bookNameCntrl.text,
        "author": contrlrList[i],
        "image": imageData
      };
      var response = await http.post(Uri.parse(address), body: data);
      if (response.statusCode == 200) {
        SnackBarWidget(context, "Your Book is Added", "Ok");
      } else {
        SnackBarWidget(context, "Something went Wrong", "Ok");
      }
    }
  }

  //_____________________________________________________________________ Img From Gallery
  _imgFromGallery() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        print(imageFile);
        imageData = base64Encode(imageFile!.readAsBytesSync());
      });
      print(imageData);
      //return imageData;
    } else {
      // return null;
    }
  }
}
