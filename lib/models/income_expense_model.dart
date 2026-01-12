import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeExpenseModel {
  final String? id;
  final double amount;
  final String description;
  final DateTime date;
  final String type;
  final String user;

  IncomeExpenseModel({
    this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.type,
    required this.user,
  });

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return IncomeExpenseModel(
      id: id,
      amount: json['amount'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate(),
      type: json['type'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount' : amount,
      'description' : description,
      'date' : date,
      'type' : type,
      'user' : user,
    };
  }
}