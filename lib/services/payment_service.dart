import 'dart:convert';
import 'package:umoja/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:umoja/models/payment_intent_model.dart';
import 'package:umoja/models/payment_method_model.dart';

class PaymentService {
  final String _baseUrl = 'https://api.stripe.com/v1';
  final String _secretKey = secretkey;

  Future<PaymentIntent> createPaymentIntent(double amount) async {
    print("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    final response = await http.post(
      Uri.parse('$_baseUrl/payment_intents'),
      headers: {
        'Authorization': 'Bearer $_secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'amount': (amount * 100).toInt().toString(),
        'currency': 'usd',
        'payment_method_types[]': 'card',
      },
    );

    

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      return PaymentIntent.fromJson(json);
    } else {
      throw Exception(
          'Failed to create payment intent: ${response.statusCode} - ${response.body}');
    }
  }


  

   Future<bool> pay(String clientSecret, String paymentMethodId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/payment_intents/$clientSecret/confirm'),
      headers: {
        'Authorization': 'Bearer $_secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'payment_method': paymentMethodId},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          'Failed to confirm payment: ${response.statusCode} - ${response.body}');
    }
  }

}