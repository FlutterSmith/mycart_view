import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/repos/checkout_repo.dart';
import 'package:checkout_payment/core/errors/failures.dart';
import 'package:checkout_payment/core/utils/stripe_service.dart';
import 'package:dartz/dartz.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentiIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentiIntentInputModel: paymentiIntentInputModel);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
