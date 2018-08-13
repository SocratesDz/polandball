import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:polandball/models/models.dart';
import 'dart:typed_data';

class RedditApi {
  final REDDIT_API = "https://www.reddit.com/";
  final SUBREDDIT = "r/polandball.json";

  Future<List<Post>> getPosts() async {
    var url = REDDIT_API + SUBREDDIT;
    return http.get(url).then((response) {
      var responseBodyMap = json.decode(response.body);
      var redditResponse = RedditResponse.fromJson(responseBodyMap);
      return redditResponse.data.children;
    });
  }

  Future<Uint8List> getImageBytes(String url) async {
    var response = await http.get(url);
    return response.bodyBytes;
  }
}
