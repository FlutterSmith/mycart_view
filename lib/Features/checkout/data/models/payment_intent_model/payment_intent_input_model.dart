class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String customer;

  PaymentIntentInputModel(
      {required this.amount, required this.currency, required this.customer});

  // to be edited ..
  Map<String, dynamic> toJson() {
    return {
      'amount': '${amount}00',
      'currency': currency,
      'customer': customer,
    };
  }
}
