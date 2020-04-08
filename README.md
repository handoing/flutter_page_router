# flutter_page_router

A front-end develop-oriented Routing Manage library that route params, context less programmatic navigation and global hooks.

[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/handoing/flutter_page_router)

[README in Chinese](README-zh.md)

#### Features：
- Modular, component-based router configuration
- Route params
- View transition effects（dependent on [flutter_page_transition](https://github.com/handoing/flutter_page_transition)）
- Context less programmatic navigation
- Global hooks

## Getting Started

Add this to your package's pubspec.yaml file:
```yaml
dependencies:
  flutter_page_router: ^0.1.0
```
You can also depend on this package stored in my repository:
```yaml
flutter_page_router:
  git:
    url: git://github.com/handoing/flutter_page_router.git
```
You should then run `flutter packages upgrade`.

## Example：

```dart
FlutterPageRouter routerInit () {

  // Define some routes
  List routes = [
    {
      r.name: 'home', // Define route name
      r.component: (params) => HomePage() // Define route component
    },
    {
      r.name: 'other',
      r.transitionType: PageTransitionType.slideInRight, // Define route transition type
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
      r.type: RouterType.NotFound, // Define not found
      r.transitionHandle: (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      }, // Define route transition handle
      r.component: (params) => NotFoundPage()
    }
  ];

  // Create the router instance
  FlutterPageRouter router = FlutterPageRouter(
      routes: routes
  );

  // Define global before hooks
  router.globalBeforeRouteUpdate((name, params, child) {
    // Requests PV can be sent uniformly, or wrap a logic component and so on
    return Container(
      child: child,
    );
  });

  return router;
}

FlutterPageRouter router = routerInit(); // Initialization Router

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      navigatorKey: router.navKey, // Define navigator Key, used to internally capture context
      onGenerateRoute: router.generator // Define generator
    );
  }
}

void main() => runApp(MyApp());
```

## PageRouterNav

[flutter_page_router](https://github.com/handoing/flutter_page_router) provides a PageRouterNav for developers to route navigation operations, it's internal use is still Navigator, call a variety of navigation operations provided by Navigator, such as push, pushNamed, pop, etc. The convenience of PageRouterNav is that there is no need to pass in the context.
for example：

```dart
PageRouterNav.pushNamed('other');

// or

PageRouterNav.pushNamed('other', params: {
 'id': 666
});
```

## Test

run test
```bash
flutter test
```

## Test Driver

run driver test
```bash
cd example/
flutter drive --target=test_driver/app.dart
```

## License

[MIT](LICENSE)
