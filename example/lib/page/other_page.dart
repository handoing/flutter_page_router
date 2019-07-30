import 'package:flutter/material.dart';
import 'package:flutter_page_router/flutter_page_router.dart';

class OtherPage extends StatefulWidget {
  final String id;
  OtherPage({Key key, this.id}) : super(key: key);

  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  String text = "Other";

  void _push() {
    PageRouterNav.pushNamed('yoyoyo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        leading: new IconButton(
          key: Key('otherPop'),
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            PageRouterNav.pop();
          },
        ),
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
            Text(widget.id,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('otherPush'),
        onPressed: _push,
        tooltip: 'Push',
        child: Icon(Icons.add),
      ),
    );
  }
}