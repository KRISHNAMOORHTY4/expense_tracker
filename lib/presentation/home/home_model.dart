import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  final String description;
  final DateTime expenseDate;
  final int amount;
  HomeModel({
    required this.description,
    required this.expenseDate,
    required this.amount,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      description: json['description'] ?? '',
      expenseDate: (json['expenseDate'] as Timestamp).toDate(),
      amount: json['amount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "expenseDate": expenseDate,
      "amount": amount,
      "createdAt": FieldValue.serverTimestamp(), // optional
    };
  }
}
