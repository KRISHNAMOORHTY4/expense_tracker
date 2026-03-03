import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  final String id;
  final String description;
  final DateTime expenseDate;
  final int amount;
  HomeModel({
    required this.id,
    required this.description,
    required this.expenseDate,
    required this.amount,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json,{required String id}) {
    return HomeModel(
      id: id,
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
