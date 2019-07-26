import 'package:flutter/material.dart';

class PageRouteObserver extends NavigatorObserver {
  List handlePushList = [];
  List handlePopList = [];
  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    handlePopList.forEach((handle) {
      handle();
    });
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    handlePushList.forEach((handle) {
      handle();
    });
  }

  void registerDidPush (handle) {
    handlePushList.add(handle);
  }

  void registerDidPop (handle) {
    handlePopList.add(handle);
  }

}