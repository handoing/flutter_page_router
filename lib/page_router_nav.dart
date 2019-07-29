import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './navigate_service.dart';

class PageRouterNav {
  static GetIt getIt = GetIt();
  static Map routeParams = {};

  PageRouterNav () {
    getIt.registerSingleton(NavigateService());
  }

  static canPop () {
    getIt<NavigateService>().canPop();
  }

  static maybePop () {
    getIt<NavigateService>().maybePop();
  }

  static popUntil (RoutePredicate predicate) {
    getIt<NavigateService>().popUntil(predicate);
  }

  static popAndPushNamed (String routeName) {
    getIt<NavigateService>().popAndPushNamed(routeName);
  }

  static pushAndRemoveUntil (Route newRoute, RoutePredicate predicate) {
    getIt<NavigateService>().pushAndRemoveUntil(newRoute, predicate);
  }

  static pushNamedAndRemoveUntil (String newRouteName, RoutePredicate predicate) {
    getIt<NavigateService>().pushNamedAndRemoveUntil(newRouteName, predicate);
  }

  static pushReplacementNamed (String routeName) {
    getIt<NavigateService>().pushReplacementNamed(routeName);
  }

  static removeRoute (Route route) {
    getIt<NavigateService>().removeRoute(route);
  }

  static removeRouteBelow (Route anchorRoute) {
    getIt<NavigateService>().removeRouteBelow(anchorRoute);
  }

  static replace ({ @required Route<dynamic> oldRoute, @required Route newRoute }) {
    getIt<NavigateService>().replace(
        anchorRoute: oldRoute,
        newRoute: newRoute
    );
  }

  static replaceRouteBelow ({ @required Route<dynamic> anchorRoute, Route newRoute }) {
    getIt<NavigateService>().replaceRouteBelow(
        anchorRoute: anchorRoute,
        newRoute: newRoute
    );
  }

  static pushReplacement (Route newRoute) {
    getIt<NavigateService>().pushReplacement(newRoute);
  }

  static pushNamed (String routeName, { Map params }) {
    routeParams = params;
    getIt<NavigateService>().pushNamed(routeName);
  }

  static push (Route route) {
    getIt<NavigateService>().push(route);
  }

  static pop () {
    getIt<NavigateService>().pop();
  }
}