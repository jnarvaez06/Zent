import 'package:personal_finances/models/income_expense_model.dart';

abstract class IncomeExpenseEvent {}

class LoadTransactions extends IncomeExpenseEvent{
  final String uId;
  LoadTransactions(this.uId);
}

class AddTransaction extends IncomeExpenseEvent {
  final IncomeExpenseModel transaction;

  AddTransaction(this.transaction);
}

class DeleteTransaction extends IncomeExpenseEvent {
  final String id;
  final String uId;

  DeleteTransaction(this.id, this.uId);
}