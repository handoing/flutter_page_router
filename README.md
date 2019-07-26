# flutter_page_router

[![Version](https://img.shields.io/badge/version-0.0.2-blue.svg)](https://github.com/handoing/flutter_page_router)

## Getting Started

```dart
FlutterPageRouter routerInit () {

  FlutterPageRouter router = FlutterPageRouter(
      routes: [
        {
          r.type: RouterType.Default,
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
      ]
  );

  router.registerDidPush(() {
    print('registerPush');
  });

  router.registerDidPop(() {
    print('registerPop');
  });

  router.globalBeforeRouteUpdate((name, params, child) {
    print('globalBeforeRouteUpdate');
    return Container(
      child: child,
    );
  });

  return router;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FlutterPageRouter router = routerInit();

    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: router.navKey,
      onGenerateRoute: router.generator,
      navigatorObservers: [
        router.observer
      ],
    );
  }
}

void main() => runApp(MyApp());
```
