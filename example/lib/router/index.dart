import 'package:flutter/material.dart';

import 'package:flutter_page_router/flutter_page_router.dart';

import '../page/home_page.dart';
import '../page/other_page.dart';
import '../page/not_found_page.dart';
import '../page/loading_page.dart';


FlutterPageRouter routerInit () {

  List<Map <r, dynamic>> routes = [
    {
      r.name: 'home',
      r.component: (params) => HomePage()
    },
    {
      r.name: 'other',
      r.transitionType: PageTransitionType.slideInRight,
      r.component: (params) {
        return new FutureBuilder<String>(
          future: Future.delayed(Duration(milliseconds: 1000)),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done: return OtherPage(id: params['id']);
              case ConnectionState.none: return LoadingPage();
              case ConnectionState.waiting: return LoadingPage();
              default:
                return new Text('Error: ${snapshot.error}');
            }
          },
        );
      }
    },
    {
      r.type: RouterType.NotFound,
      r.transitionHandle: (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      },
      r.component: (params) => NotFoundPage()
    }
  ];

  FlutterPageRouter router = FlutterPageRouter(
      routes: routes
  );

  router.globalBeforeRouteUpdate((name, params, child) {
    return Container(
      child: child,
    );
  });

  return router;
}