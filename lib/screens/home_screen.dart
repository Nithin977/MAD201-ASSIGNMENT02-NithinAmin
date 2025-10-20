//
// Course: F2025 MAD201-01 Cross Platform Mobile App Development
// Assignment: 02 – Personal Expense Tracker
// Student: Nithin Amin (A00194432)
// Date: October 2025
// File: screens/home_screen.dart
// Description: Home screen showing list of expenses, total summary, and FAB to add.
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import '../widgets/expense_card.dart';
import 'add_expense_screen.dart';
import 'expense_detail_screen.dart';

/// Displays all expenses in a ListView and provides navigation to add & view details.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// In-memory list of expenses for this session.
  final List<Expense> _expenses = [];

  /// Computes the total of all expense amounts.
  double get _total => _expenses.fold(0.0, (sum, e) => sum + e.amount);

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          // Optional total summary at the top
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Expense',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    currency.format(_total),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: _expenses.isEmpty
                ? const Center(
                    child: Text('No expenses yet. Tap + to add one.'),
                  )
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      final exp = _expenses[index];
                      return ExpenseCard(
                        expense: exp,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExpenseDetailScreen(expense: exp),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to Add Expense screen and await the result.
          final newExpense = await Navigator.push<Expense>(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );

          // If user saved a valid expense, add to list with setState.
          if (newExpense != null) {
            setState(() => _expenses.add(newExpense));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
