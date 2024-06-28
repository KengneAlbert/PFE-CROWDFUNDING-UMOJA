
class PaymentIntent {
  String clientSecret;
  String paymentMethodId;
  double amount;

  PaymentIntent({
    required this.clientSecret,
    required this.paymentMethodId,
    required this.amount,
  });

  static PaymentIntent fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      clientSecret: json['client_secret'], 
      paymentMethodId: json['payment_method'], 
      amount: json['amount'].toDouble() / 100, 
    );
  }
}