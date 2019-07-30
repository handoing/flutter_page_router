import 'package:flutter/material.dart';

import 'package:flutter_page_router/flutter_page_router.dart';
import './router/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FlutterPageRouter router = routerInit();

    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      navigatorKey: router.navKey,
      onGenerateRoute: router.generator
    );
  }
}

