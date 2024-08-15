import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'Features/checkout/presentation/views/my_cart_view.dart';

void main() {
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}

// PaymentIntentObject create payment intent (amount, currency, payment method)
// init payment sheet (payment intent client secret)

// presentPaymentSheet()
