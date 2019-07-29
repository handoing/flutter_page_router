# flutter_page_router

一个flutter的路由管理器

[![Version](https://img.shields.io/badge/version-0.0.3-blue.svg)](https://github.com/handoing/flutter_page_router)

功能：
- 模块化的、基于组件的路由配置
- 可定义路由参数
- 可定义视图过渡效果（内置flutter_page_transition）
- 外部不依赖Context的编程式的导航
- 全局钩子

## Getting Started

引入依赖项

```yaml
flutter_page_router:
  git:
    url: git://github.com/handoing/flutter_page_router.git
```

使用：

```dart
FlutterPageRouter routerInit () {

  FlutterPageRouter router = FlutterPageRouter(
      routes: [
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
      ]
  );

  router.globalBeforeRouteUpdate((name, params, child) {
    // 可以统一处理PV，或外包一个逻辑组件等
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
      initialRoute: 'home',
      onGenerateRoute: router.generator
    );
  }
}

void main() => runApp(MyApp());
```

## License

[MIT](LICENSE)
