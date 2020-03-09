import 'package:flutter/material.dart';

import 'package:flutter_page_router/flutter_page_router.dart';
import './router/index.dart';

void main() => runApp(MyApp());

FlutterPageRouter router = routerInit();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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

