import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../example/lib/main.dart';

void main() {
  testWidgets('test push and pop', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

    expect(find.widgetWithText(AppBar, 'Home'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pumpAndSettle(const Duration(milliseconds: 1200));

    expect(find.widgetWithText(AppBar, 'Other'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'NotFound'), findsOneWidget);

    await tester.tap(find.byKey(Key('notFoundPop')));

    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Other'), findsOneWidget);

    await tester.tap(find.byKey(Key('otherPop')));

    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Home'), findsOneWidget);

  });
}
