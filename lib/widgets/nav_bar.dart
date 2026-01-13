import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances/app_theme.dart';
import 'package:personal_finances/models/income_expense_model.dart';
import 'package:personal_finances/blocs/income_expense/income_expense_bloc.dart';
import 'package:personal_finances/blocs/income_expense/income_expense_event.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.greenFinanceTheme.dividerColor,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTabSelected,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppTheme.greenFinanceTheme.primaryColor,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Spending'),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),

        // Botón flotante
        Positioned(
          top: -30,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: FloatingActionButton(
            backgroundColor: AppTheme.greenFinanceTheme.primaryColor,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // Permite que el modal suba con el teclado
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => const _TransactionFormModal(),
              );
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Widget interno Stateful para manejar el formulario sin perder el foco
class _TransactionFormModal extends StatefulWidget {
  const _TransactionFormModal();

  @override
  State<_TransactionFormModal> createState() => _TransactionFormModalState();
}

class _TransactionFormModalState extends State<_TransactionFormModal> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _addTransaction(String amount, String description, String date, String type) {
    final parsedAmount = double.tryParse(amount);
    final firebaseUser = FirebaseAuth.instance.currentUser;

    print(date);

    List<String> dateParts = date.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    DateTime dateObject = DateTime(year, month, day);

    if (parsedAmount == null || parsedAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final transaction = IncomeExpenseModel(
      amount: parsedAmount,
      description: description.isEmpty ? 'no description' : description,
      date: dateObject,
      type: type,
      user: firebaseUser!.uid,
    );

    // Accedemos al Bloc y enviamos el evento
    context.read<IncomeExpenseBloc>().add(AddTransaction(transaction));

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New Transaction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                autofocus: true, // El foco se mantiene aquí al abrirse
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              TextField(
                controller: dateController,
                readOnly: true, // Evita que se abra el teclado físico
                decoration: InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), // Fecha mínima
                    lastDate: DateTime(2101), // Fecha máxima
                  );

                  if (pickedDate != null) {
                    setState(() {
                      dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    });
                  }
                },
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () => _addTransaction(
                        amountController.text,
                        descriptionController.text,
                        dateController.text,
                        'income',
                      ),
                      child: const Text('Income', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      onPressed: () => _addTransaction(
                        amountController.text,
                        descriptionController.text,
                        dateController.text,
                        'expense',
                      ),
                      child: const Text('Expense', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}