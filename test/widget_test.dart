import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:citycleaner/main.dart';

void main() {
  testWidgets('App loads without crash', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
