import 'package:uuid/uuid.dart';
class PaymentInfo {
  final String apikey;
  final String siteId;
  final String notifyUrl;
  final int amount;
  final String currency;
  final String? transactionId;
  final String description;
  final String channels;

  PaymentInfo({
    required this.apikey,
    required this.siteId,
    required this.notifyUrl,
    required this.amount,
    required this.currency,
    required this.description,
    required this.channels,
    String? transactionId,
  }) : transactionId = transactionId ?? Uuid().v4();
}
