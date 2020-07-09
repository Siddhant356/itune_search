import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itune_flutter/model/result_class.dart';

class ResultPage extends StatefulWidget {
  final String text;

  const ResultPage({Key key, this.text}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  Future<ResultList> data;

  @override
  void initState(){
    super.initState();
    Network network = Network('https://itunes.apple.com/search?term=${widget.text}');
    data = network.loadResults();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Let's Play"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<ResultList> snapshot){
              List<Result> allResults;
              if(snapshot.hasData) {
                allResults =snapshot.data.results;
                return createListView(allResults, context);
              }else {
                return Center(child: CircularProgressIndicator());
              }
            }
        ),
      ),
    );
  }
  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, int index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text("${data[index].trackName}", ),
                  subtitle: (data[index].trackExplicitness=="notExplicit")?Text("${data[index].artistName}"):Row(
                        children: <Widget>[
                          Icon(Icons.explicit, color: Colors.grey, size: 18,),

                              Text("${data[index].artistName}"),
                        ],
                      ),

                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage("${data[index].artworkUrl60}"),

                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);
  Future<ResultList> loadResults() async {
    final response = await get(Uri.encodeFull(url));
    if(response.statusCode == 200) {
      var res = json.decode(response.body);
//       print(res["results"]);
      return ResultList.fromJson(res["results"]);
    }else {
      throw Exception("Failed to get post");
    }
  }
}