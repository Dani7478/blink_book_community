import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  TextEditingController _categoryCntrl=new TextEditingController();
  String _SelectDeleteCategory="Science";
  List? resultList;
  List<String>? _deleteCategoryList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {

    });
    int? deletecount=_deleteCategoryList?.length;
    print(deletecount);
    // print("deleteCategory = ${deletecount}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add or Remove Category",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
        ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Select Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20)
                    ),
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                     child:  TextFormField(
                       controller: _categoryCntrl,
                       decoration: InputDecoration(
                           hintText: "Enter Category",
                           border:InputBorder.none,
                           prefixIcon: Icon(Icons.category),
                           hintStyle: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.w600,
                           )
                       ),

                     ),
                   ),
                  ),

                ],
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 160),
                child: GestureDetector(
                  onTap: () async{
                    String address="http://192.168.43.45/BlinkBookApi/api/Category/addCategory";
                    var data={
                      "cname":_categoryCntrl.text,
                    };
                 var respons= await http.post(Uri.parse(address), body: data);
                 if(respons.statusCode==200)
                   {
                     print(respons.body);
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                   }
                 else
                   {
                     print(respons.body);
                   }

                  },
                  child: Container(
                    height:50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                   child: const Center(
                      child: Text("Add",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 80,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Select Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: DropdownButton(
                        dropdownColor: Colors.redAccent,
                        value: _SelectDeleteCategory,
                        items:_deleteCategoryList?.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(items, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                          );
                        }
                        ).toList(),
                        onChanged: (value) {
                          _SelectDeleteCategory=value.toString();
                          setState(() {});
                          print(_SelectDeleteCategory);
                        },

                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 160),
                child: GestureDetector(
                  onTap: () async{
                    String address="http://192.168.43.45/BlinkBookApi/api/Category/deleteCategory?newCategory=$_SelectDeleteCategory";
                   var respons=await http.get(Uri.parse(address));
                   if(respons.statusCode==200)
                     {
                       print("Data Delted ");
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                     }
                   else
                     {
                       print("Something Went Wrong");
                     }
                  },
                  child: Container(
                    height:50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text("Delete",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                  ),
                ),
              ),
             // Text("$_deleteCategoryList?.length");
            ],
          ),
        ),
      ),
    );
  }
  getData() async
  {
    String address="http://192.168.43.45/BlinkBookApi/api/Category/getAllCategory";
   var respons= await http.get(Uri.parse(address));
   if(respons.statusCode==200)
     {
       resultList=json.decode(respons.body);
       setState(() {});
       int? count=resultList?.length; //2
       _SelectDeleteCategory=resultList![0]["cname"];
       for(int i=0; i<count! ; i++)
         {
           _deleteCategoryList?.add(resultList![i]["cname"].toString());
           print(resultList![i]["cname"]);
         }
       setState(() {

       });
     }

  }

}
