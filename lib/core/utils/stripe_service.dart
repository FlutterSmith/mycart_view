import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment/core/utils/api_keys.dart';
import 'package:checkout_payment/core/utils/api_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createpaymentIntent(
      PaymentIntentInputModel paymentiIntentInputModel) async {
    var response = await apiService.post(
        url: 'https://api.stripe.com/v1/payment_intents',
        body: paymentiIntentInputModel.toJson(),
        token: ApiKeys.secretKey);

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'Example Inc.',

    ));
  }
}
