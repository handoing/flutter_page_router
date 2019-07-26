library flutter_page_router;

import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:get_it/get_it.dart';
import './common_type.dart';
import './navigate_service.dart';
import './route_observer.dart';

export 'package:flutter_page_transition/flutter_page_transition.dart';
export './common_type.dart';

class FlutterPageRouter {
  List<Map <r, dynamic>> routes;
  GlobalKey navKey;
  Function globalBeforeRouteUpdateHandle;
  Map route;
  PageRouteObserver observer = PageRouteObserver();

  static GetIt getIt = GetIt();
  static Map _params = {};

  FlutterPageRouter({routes}) {
    this.routes = routes;
    init();
  }

  void init() {
    getIt.registerSingleton(NavigateService());
    navKey = getIt<NavigateService>().key;
  }

  Widget matchWidget (String name) {
    Widget currentWidget;
    routes.forEach((config) {
      if (name == config[r.name]) {
        currentWidget = config[r.component](FlutterPageRouter._params);
        route = config;
      }
    });

    if (currentWidget == null && name == '/') {
      routes.forEach((config) {
        if (config[r.type] == RouterType.Default) {
          currentWidget = config[r.component](FlutterPageRouter._params);
          route = config;
        }
      });
    }

    if (currentWidget == null) {
      routes.forEach((config) {
        if (config[r.type] == RouterType.NotFound) {
          currentWidget = config[r.component](FlutterPageRouter._params);
          route = config;
        }
      });
    }

    return globalBeforeRouteUpdateHandle(name, FlutterPageRouter._params, currentWidget);
  }

  PageRouteBuilder generator (RouteSettings routeSettings) {
    return new PageRouteBuilder<dynamic>(
        settings: routeSettings,
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return matchWidget(routeSettings.name);
        },
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {

          Widget buildWidget;

          PageTransitionType type = PageTransitionType.slideInLeft;

          if (route != null && route[r.transitionType] != null) {
            type = route[r.transitionType];
          }

          if (type == null) {
            buildWidget = route[r.transitionHandle](Curves.linear, animation, secondaryAnimation, child);
          } else {
            buildWidget = effectMap[type](Curves.linear, animation, secondaryAnimation, child);
          }

          return buildWidget;
        }
    );
  }

  void globalBeforeRouteUpdate (handle) {
    globalBeforeRouteUpdateHandle = handle;
  }

  static pushNamed (String name, { Map params }) {
    _params = params;
    getIt<NavigateService>().pushNamed(name);
  }

  static push (String name) {
    getIt<NavigateService>().push(name);
  }

  static pop (String name) {
    getIt<NavigateService>().pop();
  }

  void registerDidPush (handle) {
    observer.registerDidPush(handle);
  }

  void registerDidPop (handle) {
    observer.registerDidPop(handle);
  }

}