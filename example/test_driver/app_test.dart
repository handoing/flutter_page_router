import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';

Future<File> takeScreenshot(FlutterDriver driver, String path) async {
  final List<int> pixels = await driver.screenshot();
  final File file = new File(path);
  return await file.writeAsBytes(pixels);
}

void main() {
  group('Default test', () {

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });

    test('driver test route push and pop', () async {

      await takeScreenshot(driver, './screenshots/page-frame-home.png');
      await driver.tap(find.byValueKey('homePush'));
      await driver.waitFor(find.byValueKey('otherPush'));
      await takeScreenshot(driver, './screenshots/page-frame-other.png');
      await driver.tap(find.byValueKey('otherPush'));
      await driver.waitFor(find.byValueKey('notFoundPush'));
      await takeScreenshot(driver, './screenshots/page-frame-not-found.png');

      await driver.tap(find.byValueKey('notFoundPop'));
      await driver.waitFor(find.byValueKey('otherPop'));
      await driver.tap(find.byValueKey('otherPop'));
      await driver.waitFor(find.byValueKey('homePush'));

      print('Success!');
    });
  });
}
