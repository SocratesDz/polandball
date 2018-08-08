import 'package:flutter_test/flutter_test.dart';
import 'package:polandball/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  test('Fetch posts from Reddit', () async {
    var api = RedditApi();
    var posts = await api.getPosts();
    expect(posts.isEmpty, false);
  });

  test('Fetch image as base64', () async {
    var api = RedditApi();
    var posts = await api.getPosts();
    posts = posts.where((post) => post.data.postHint == "image").toList();
    var rawImage = await http.get(posts.first.data.url);
    var base64Image = base64Encode(rawImage.bodyBytes);

    expect(rawImage != null, true);
  });
}
