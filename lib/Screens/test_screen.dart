import 'package:flutter/material.dart';




class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing"),
      ),
      body:Column(
        children:  [
          GestureDetector(
            onTap: (){

            },
            child: Card(
              elevation: 10.0,
              color: Colors.redAccent,
              child:ListTile(
                title: Text("Chapter 1"),
                subtitle: Text("Stateless and Statefull"),
                leading: Icon(Icons.mark_chat_read_outlined, color: Colors.white,),
              trailing: Text("20 %"),
              ),
            ),
          ),
          Card(
            color: Colors.redAccent,
            child:ListTile(
              title: Text("Chapter 2"),
              subtitle: Text("Stateless and Statefull"),
              leading: Icon(Icons.mark_chat_read_outlined, color: Colors.white,),
              trailing: Text("10 %"),
            ),
          ),
          Card(
            color: Colors.redAccent,
            child:ListTile(
              title: Text("Chapter 1"),
              subtitle: Text("Stateless and Statefull"),
              leading: Icon(Icons.mark_chat_read_outlined, color: Colors.white,),
              trailing: Text("25 %"),
            ),
          ),
          Card(
            color: Colors.redAccent,
            child:ListTile(
              title: Text("Chapter 1"),
              subtitle: Text("Stateless and Statefull"),
              leading: Icon(Icons.mark_chat_read_outlined, color: Colors.white,),
              trailing: Text("28 %"),
            ),
          ),

        ],
      ),
    );
  }
}
