import 'package:checkout_payment/Features/checkout/data/models/create_customer_model/create_customer_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/create_customer_model/create_customer_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/init_payment_sheet_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment/core/utils/api_keys.dart';
import 'package:checkout_payment/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentiIntentInputModel) async {
    var response = await apiService.post(
        url: 'https://api.stripe.com/v1/payment_intents',
        body: paymentiIntentInputModel.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        token: ApiKeys.secretKey);

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
      customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKeySecret,
      customerId: initPaymentSheetInputModel.customerId,
      merchantDisplayName: initPaymentSheetInputModel.merchantDisplayName,
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentiIntentInputModel}) async {
    var paymentIntentModel =
        await createPaymentIntent(paymentiIntentInputModel);
    var ephemeralKeyModel =
        await createEphemeralKey(customerId: paymentiIntentInputModel.customer);

    var initPaymentSheetInputModel = InitPaymentSheetInputModel(
        clientSecret: paymentIntentModel.clientSecret!,
        ephemeralKeySecret: ephemeralKeyModel.secret!,
        customerId: paymentiIntentInputModel.customer,
        merchantDisplayName: 'Flutter Stripe Store');

    await initPaymentSheet(
        initPaymentSheetInputModel: initPaymentSheetInputModel);

    await displayPaymentSheet();
  }

  Future<CreateCustomerModel> createCustomer(
      CreateCustomerInputModel createCustomerInputModel) async {
    var response = await apiService.post(
        url: 'https://api.stripe.com/v1/customers',
        body: createCustomerInputModel.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        token: ApiKeys.secretKey);

    var createCustomerModel = CreateCustomerModel.fromJson(response.data);
    return createCustomerModel;
  }

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await apiService.post(
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        body: {
          'customer': customerId,
        },
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Stripe-Version': '2024-06-20',
        },
        contentType: Headers.formUrlEncodedContentType,
        token: ApiKeys.secretKey);

    var ephemeralKey = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKey;
  }
}
