import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentiIntentInputModel});
}
