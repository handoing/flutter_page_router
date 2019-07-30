# flutter_page_router

一个面向前端开发者的flutter的路由管理库，可定义路由参数、无context的导航式路由和全局钩子等。

[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/handoing/flutter_page_router)

[README in English](README.md)

#### 主要功能有：
- 模块化的、基于组件的路由配置
- 可定义路由参数
- 可定义视图过渡效果（依赖[flutter_page_transition](https://github.com/handoing/flutter_page_transition)）
- 外部不依赖Context的编程式的导航
- 全局钩子

## Getting Started

pubspec.yaml中添加flutter_page_router依赖：
```yaml
dependencies:
  flutter_page_router: ^0.1.0
```
或者添加github仓库的依赖：
```yaml
flutter_page_transition:
  git:
    url: git://github.com/handoing/flutter_page_router.git
```
记得执行 `flutter packages upgrade` 更新依赖。

## Example：

```dart
FlutterPageRouter routerInit () {

  // 定义路由映射
  List routes = [
    {
      r.name: 'home', // 定义路由名称
      r.component: (params) => HomePage() // 定义路由组件
    },
    {
      r.name: 'other',
      r.transitionType: PageTransitionType.slideInRight, // 定义路由过渡类型
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
      r.type: RouterType.NotFound, // 定义not found
      r.transitionHandle: (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      }, // 定义路由过渡效果
      r.component: (params) => NotFoundPage()
    }
  ];

  // 创建路由实例
  FlutterPageRouter router = FlutterPageRouter(
      routes: routes
  );

  // 全局前置钩子
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

    FlutterPageRouter router = routerInit(); // 初始化路由

    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      navigatorKey: router.navKey, // 定义导航的Key，用来内部获取context
      onGenerateRoute: router.generator // 定义generator
    );
  }
}

void main() => runApp(MyApp());
```

## PageRouterNav

[flutter_page_router](https://github.com/handoing/flutter_page_router)提供了一个PageRouterNav供开发者进行路由导航操作，其内部使用的还是Navigator，可调用Navigator提供的多种导航操作，例如push、pushNamed、pop等，PageRouterNav方便之处在于不需要传入context。
如下：

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
