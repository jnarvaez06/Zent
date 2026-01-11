import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances/blocs/income_expense/income_expense_event.dart';
import 'package:personal_finances/blocs/income_expense/income_expense_state.dart';
import 'package:personal_finances/repositories/income_expense_repository.dart';

class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseState> {
  final IncomeExpenseRepository repository;
  
  IncomeExpenseBloc(this.repository) : super(TransactionLoading()) {
    on<LoadTransactions>((event, emit) async {
      try {
        emit(TransactionLoading());
        final transactions = await repository.fetchTransactions();
        emit(TransactionLoaded(transactions));

      } catch (e) {
        emit(TransactionError('Error loading transaction:: $e'));
      }
    });

    on<AddTransaction>((event, emit) async {
      try {
        await repository.addTransaction(event.transaction);

        final transactions = await repository.fetchTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Error adding transaction: $e'));
      }
    });

    on<DeleteTransaction>((event, emit) async {
      try {
        await repository.deleteTrasaction(event.id);

        final transactions = await repository.fetchTransactions();

        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Error deleting transaction: $e'));
      }
    });
  }
}