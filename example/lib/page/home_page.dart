import 'package:flutter/material.dart';
import 'package:flutter_page_router/flutter_page_router.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "Home";
  String id = "xxxxxx";

  void _push() {
    PageRouterNav.pushNamed('other', params: {
      "id": id
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$text',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('homePush'),
        onPressed: _push,
        tooltip: 'Push',
        child: Icon(Icons.add),
      ),
    );
  }
}