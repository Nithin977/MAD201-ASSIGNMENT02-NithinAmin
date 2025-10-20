//
// Course: F2025 MAD201-01 Cross Platform Mobile App Development
// Assignment: 02 – Personal Expense Tracker
// Student: Nithin Amin (A00194432)
// Date: October 2025
// File: models/expense.dart
// Description: Defines the Expense data model used across the app.
//

/// Represents an expense entry with title, amount, description, and date.
class Expense {
  /// Title of the expense (e.g., "Groceries").
  final String title;

  /// Amount spent in CAD.
  final double amount;

  /// Optional longer description about the expense.
  final String description;

  /// The date the expense occurred.
  final DateTime date;

  /// Creates a new [Expense] instance.
  const Expense({
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
  });

  @override
  String toString() =>
      'Expense(title: $title, amount: $amount, date: ${date.toIso8601String()})';
}
