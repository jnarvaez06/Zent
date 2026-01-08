import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_finances/models/income_expense_model.dart';

class IncomeExpenseRepository {
  final FirebaseFirestore _firestore;

  IncomeExpenseRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<IncomeExpenseModel>> fetchTransactions () async {
    try {
      final querySnapShot = await _firestore.collection('transactions').get();

      return querySnapShot.docs.map((doc) {
        return IncomeExpenseModel(
          id : doc.id,
          amount : doc["amount"],
          date : (doc["date"] as Timestamp).toDate(),
          description : doc["description"],
          type: doc["type"]
        );
      }).toList();
    } catch (e) {
      throw Exception("Error fetching transaction: $e");
    }
  }
}