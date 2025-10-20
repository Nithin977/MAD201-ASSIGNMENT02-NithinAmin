//
// Course: F2025 MAD201-01 Cross Platform Mobile App Development
// Assignment: 02 – Personal Expense Tracker
// Student: Nithin Amin (A00194432)
// Date: October 2025
// File: widgets/expense_card.dart
// Description: A reusable card widget to display an expense in list views.
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

/// A material card showing expense title, amount, and formatted date.
class ExpenseCard extends StatelessWidget {
  /// The expense to render.
  final Expense expense;

  /// Called when the user taps the card.
  final VoidCallback? onTap;

  const ExpenseCard({super.key, required this.expense, this.onTap});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency();
    final dateFmt = DateFormat.yMMMEd();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(dateFmt.format(expense.date)),
        trailing: Text(
          currency.format(expense.amount),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
