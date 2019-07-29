library flutter_page_router;

import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import './common_type.dart';
import './navigate_service.dart';
import './route_observer.dart';
import './page_router_nav.dart';

export 'package:flutter_page_transition/flutter_page_transition.dart';
export './common_type.dart';
export './page_router_nav.dart';

class FlutterPageRouter {
  List<Map <r, dynamic>> routes;
  GlobalKey navKey;
  Function globalBeforeRouteUpdateHandle;
  Map route;
  Function notFoundHandle;
  PageRouteObserver observer = PageRouteObserver();
  PageRouterNav pageNav = new PageRouterNav();

  FlutterPageRouter({routes}) {
    this.routes = routes;
    navKey = PageRouterNav.getIt<NavigateService>().key;
  }

  Widget matchWidget (String name) {
    Widget currentWidget;
    routes.forEach((config) {
      if (name == config[r.name]) {
        currentWidget = config[r.component](PageRouterNav.routeParams);
        route = config;
      }
      if (notFoundHandle == null && config[r.type] == RouterType.NotFound) {
        notFoundHandle = config[r.component];
      }
    });

    if (currentWidget == null) {
      currentWidget = notFoundHandle(PageRouterNav.routeParams);
    }

    return globalBeforeRouteUpdateHandle(name, PageRouterNav.routeParams, currentWidget);
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

  void registerDidPush (handle) {
    observer.registerDidPush(handle);
  }

  void registerDidPop (handle) {
    observer.registerDidPop(handle);
  }

}