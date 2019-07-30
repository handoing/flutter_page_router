import 'package:flutter/material.dart';
import 'package:flutter_page_router/flutter_page_router.dart';

class NotFoundPage extends StatefulWidget {
  NotFoundPage({Key key}) : super(key: key);

  @override
  _NotFoundPageState createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> with RouteAware {
  String text = "NotFound";

  void _push() {
    PageRouterNav.pushNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        leading: new IconButton(
          key: Key('notFoundPop'),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('notFoundPush'),
        onPressed: _push,
        tooltip: 'Push',
        child: Icon(Icons.add),
      ),
    );
  }
}