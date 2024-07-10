import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  final int amount;
  final String status;
  final DateTime timestamp;
  final String transactionId;

  WalletModel({
    required this.amount,
    required this.status,
    required this.timestamp,
    required this.transactionId,
  });

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      amount: map['amount'],
      status: map['status'],
      timestamp: (map['timestamp'] as Timestamp).toDate(), // Assumes Firestore Timestamp
      transactionId: map['transactionId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'status': status,
      'timestamp': timestamp,
      'transactionId': transactionId,
    };
  }
}
