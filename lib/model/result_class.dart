class ResultList {
 final List<Result> results;

  ResultList({this.results});

  factory ResultList.fromJson(List<dynamic> parsedJson){
   List<Result> results = new List<Result>();
   results = parsedJson.map((i)=>Result.fromJson(i)).toList();
   return new ResultList(results: results);
  }

}


class Result{
  String trackName;
  String artistName;
  String artworkUrl60;
  String trackExplicitness;
  String primaryGenreName;

  Result({this.trackName, this.artistName, this.artworkUrl60,
      this.trackExplicitness, this.primaryGenreName});
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
    trackName: json["trackName"],
    artistName: json["artistName"],
      artworkUrl60: json["artworkUrl60"],
      trackExplicitness: json["trackExplicitness"],
      primaryGenreName: json["primaryGenreName"]

    );
  }
}