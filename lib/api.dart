import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:favoritosdoyoutube/models/video.dart';
import 'package:favoritosdoyoutube/keys.dart';

class Api {

  String _nextToken;
  String _search;

  Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      // Tudo certo

      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];
      List<Video> videos = decoded["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception("deu erro");
    }
  }
}
