import 'dart:convert';
import 'package:umoja/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:umoja/models/cinetpay.dart';
import 'package:umoja/models/payment_intent_model.dart';
import 'package:umoja/models/payment_method_model.dart';
import 'package:umoja/viewmodels/finance/top_up_method_payment_viewModel.dart';

class PaymentService {
  final String _baseUrl = 'https://api.stripe.com/v1';
  final String secretKey = secretkey;

  // StripeService(this.secretKey);

    Future<Map<String, dynamic>> createPaymentIntent(int amount) async {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount.toString(),
          'currency': 'usd',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent');
      }
    }

    Future<String> initiatePayment(PaymentInfo paymentInfo) async {
    final url = Uri.parse('https://api-checkout.cinetpay.com/v2/payment');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'apikey': paymentInfo.apikey,
        'site_id': paymentInfo.siteId,
        'notify_url': paymentInfo.notifyUrl,
        'amount': paymentInfo.amount,
        'currency': paymentInfo.currency,
        'transaction_id': paymentInfo.transactionId,
        'description': paymentInfo.description,
        'channels': paymentInfo.channels,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['payment_url'];
    } else {
      throw Exception('Failed to initiate payment');
    }
  }

 

  //  Future<bool> pay(String clientSecret, String paymentMethodId) async {
  //   final response = await http.post(
  //     Uri.parse('$_baseUrl/payment_intents/$clientSecret/confirm'),
  //     headers: {
  //       'Authorization': 'Bearer $secretKey',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //     },
  //     body: {'payment_method': paymentMethodId},
  //   );

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     throw Exception(
  //         'Failed to confirm payment: ${response.statusCode} - ${response.body}');
  //   }
  // }

}