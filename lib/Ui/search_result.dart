import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, int index){
            return Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: (data[index].trackName != null)
                        ?Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "${data[index].trackName}",
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                        :Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "${data[index].wrapperType}",
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    subtitle: (data[index].trackExplicitness=="notExplicit")
                        ?Text("${data[index].artistName}", overflow: TextOverflow.ellipsis, softWrap: true,)
                        :Row(
                          children: <Widget>[
                            Icon(
                              Icons.explicit, color: Colors.grey, size: 18,
                            ),
                            Expanded(
                                child: Text(
                                    "${data[index].artistName}", overflow: TextOverflow.ellipsis, softWrap: true,)
                            ),
                          ],
                        ),
                    leading: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage("${data[index].artworkUrl60}"),

                        ),
                      ],
                    ),
                    trailing: Chip(
                      elevation: 3,
                      label: Text(
                        "${data[index].primaryGenreName}",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      backgroundColor: Colors.black87,
                    ),
                  ),
                ],
              ),
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