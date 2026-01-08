import 'package:personal_finances/models/income_expense_model.dart';

abstract class IncomeExpenseState {}

class TransactionLoading extends IncomeExpenseState {}

class TransactionLoaded extends IncomeExpenseState {
  final List<IncomeExpenseModel> transactions;

  TransactionLoaded(this.transactions);
}

class TransactionError extends IncomeExpenseState {
  final String message;

  TransactionError(this.message);
}