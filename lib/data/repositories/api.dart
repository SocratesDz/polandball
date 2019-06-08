import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:polandball/data/constants.dart';
import 'package:polandball/domain/entities/models.dart';

class RedditApi {
  final REDDIT_API = "https://www.reddit.com/";
  final SUBREDDIT = "r/polandball.json";

  Future<Data> getPostsData({String after, String before}) async {
    var uri = Uri.https(REDDIT_AUTHORITY, POLANDBALL_SUBREDDIT, {
      "after": after,
      "before": before
    });
    return http.get(uri.toString()).then((response) {
      var responseBodyMap = json.decode(response.body);
      var redditResponse = RedditResponse.fromJson(responseBodyMap);
      return redditResponse.data;
    });
  }

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
