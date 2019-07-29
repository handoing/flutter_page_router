import 'package:flutter/material.dart';

class NavigateService {
  final GlobalKey<NavigatorState> key = GlobalKey(debugLabel: 'flutter_page_router_navigate_key');

  NavigatorState get navigator => key.currentState;

  get canPop => navigator.canPop;
  get maybePop => navigator.maybePop;
  get popUntil => navigator.popUntil;
  get popAndPushNamed => navigator.popAndPushNamed;
  get pushAndRemoveUntil => navigator.pushAndRemoveUntil;
  get pushNamedAndRemoveUntil => navigator.pushNamedAndRemoveUntil;
  get pushReplacementNamed => navigator.pushReplacementNamed;
  get removeRoute => navigator.removeRoute;
  get removeRouteBelow => navigator.removeRouteBelow;
  get replace => navigator.replace;
  get replaceRouteBelow => navigator.replaceRouteBelow;
  get pushNamed => navigator.pushNamed;
  get push => navigator.push;
  get pop => navigator.pop;
  get pushReplacement => navigator.pushReplacement;
}