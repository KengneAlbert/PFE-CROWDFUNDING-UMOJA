import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umoja/services/payment_service.dart';

final stripeProvider = Provider((ref) => StripeViewModel());

class StripeViewModel {

  Future<Map<String, dynamic>> createPaymentIntent(int amount) async {
    return await PaymentService().createPaymentIntent(amount);
  }
}
