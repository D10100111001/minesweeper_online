// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minesweeper_online/counter.dart';

void main() {
  testWidgets('counter renders a padded value', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Counter(
          label: 'Mines Remaining',
          count: 5,
        ),
      ),
    );

    expect(find.text('005'), findsOneWidget);
  });
}
