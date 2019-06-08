import 'package:flutter/material.dart';
import 'package:polandball/app/pages/posts_page.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: PostsPage(),
      routes: {PostsPage.PATH: (context) => PostsPage()},
    );
  }
}
