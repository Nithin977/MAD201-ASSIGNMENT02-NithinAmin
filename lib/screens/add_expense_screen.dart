//
// Course: F2025 MAD201-01 Cross Platform Mobile App Development
// Assignment: 02 – Personal Expense Tracker
// Student: Nithin Amin (A00194432)
// Date: October 2025
// File: screens/add_expense_screen.dart
// Description: Form to capture a new expense, validate user input,
// and return the result to the Home Screen.
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

/// Screen containing text fields and a date picker to add a new [Expense].
class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text inputs
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Opens a material date picker and stores user's selection.
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDate: _selectedDate ?? now,
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  /// Validates the form, creates an [Expense], and pops with the result.
  void _saveExpense() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount must be greater than 0')),
      );
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a date')));
      return;
    }

    final expense = Expense(
      title: _titleController.text.trim(),
      amount: amount,
      description: _descriptionController.text.trim(),
      date: _selectedDate!,
    );

    // Pop back to HomeScreen with the new expense
    Navigator.pop(context, expense);
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMd();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Expense Title',
                  hintText: 'e.g., Groceries or Rent',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount (CAD)',
                  hintText: 'e.g., 24.99',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Amount is required';
                  }
                  final v = double.tryParse(value.trim());
                  if (v == null) {
                    return 'Enter a valid number';
                  }
                  if (v <= 0) {
                    return 'Amount must be greater than 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Optional notes about this expense',
                  prefixIcon: Icon(Icons.notes),
                ),
                minLines: 2,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _selectedDate == null
                      ? 'Pick Date'
                      : dateFmt.format(_selectedDate!),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveExpense,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Expense'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
