import 'package:personal_finances/models/income_expense_model.dart';

abstract class IncomeExpenseEvent {}

class LoadTransactions extends IncomeExpenseEvent{}

class AddTransaction extends IncomeExpenseEvent {
  final IncomeExpenseModel transaction;

  AddTransaction(this.transaction);
}

class DeleteTransaction extends IncomeExpenseEvent {
  final String id;

  DeleteTransaction(this.id);
}