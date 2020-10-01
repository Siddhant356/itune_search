
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itune_flutter/Ui/search_result.dart';


class Search extends StatefulWidget {


  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Let's Play"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8, left:8, right: 8),
        child:
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow:  [BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 6.0,
                  ),]
                ),
                child: Center(
                  child: TextField(
                    onSubmitted: (text){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>ResultPage(text: text,)
                      ),
                      );
                    },
                    style: TextStyle(fontSize: 25, ),
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}


