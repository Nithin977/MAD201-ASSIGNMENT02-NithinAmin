//
// Course: F2025 MAD201-01 Cross Platform Mobile App Development
// Assignment: 02 – Personal Expense Tracker
// Student: Nithin Amin (A00194432)
// Date: October 2025
// File: screens/expense_detail_screen.dart
// Description: Read-only view of a selected expense with a back button.
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

/// Shows a read-only view for a specific [Expense].
class ExpenseDetailScreen extends StatelessWidget {
  /// Expense to display
  final Expense expense;

  const ExpenseDetailScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency();
    final dateFmt = DateFormat.yMMMMd();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Field(label: 'Title', value: expense.title),
            _Field(label: 'Amount', value: currency.format(expense.amount)),
            _Field(label: 'Date', value: dateFmt.format(expense.date)),
            _Field(label: 'Description', value: expense.description.isEmpty ? '—' : expense.description),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small helper to render a label-value pair.
class _Field extends StatelessWidget {
  final String label;
  final String value;

  const _Field({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelMedium;
    final valueStyle = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: labelStyle),
          const SizedBox(height: 4),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
