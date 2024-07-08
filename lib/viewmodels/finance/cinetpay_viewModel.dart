import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/models/cinetpay.dart';
import 'package:umoja/services/payment_service.dart';

final paymentProvider = Provider((ref) => PaymentViewModel());

class PaymentViewModel {
  final PaymentService _paymentService = PaymentService();

  Future<String> initiatePayment(PaymentInfo paymentInfo) async {
    return await _paymentService. initiatePayment(paymentInfo);
  }
}
