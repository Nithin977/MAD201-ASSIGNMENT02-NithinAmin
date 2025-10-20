// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mad201_a2_expense_tracker/main.dart';

void main() {
  testWidgets('Expense Tracker app loads correctly', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // Verify that the home screen title appears.
    expect(find.text('Expense Tracker'), findsOneWidget);

    // Verify that the floating action button (FAB) exists.
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the '+' FAB and trigger a frame to navigate to Add Expense screen.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that the Add Expense screen loaded by checking for "Add Expense" title.
    expect(find.text('Add Expense'), findsOneWidget);
  });
}
