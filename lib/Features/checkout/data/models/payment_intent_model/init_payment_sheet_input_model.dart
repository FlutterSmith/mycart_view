class InitPaymentSheetInputModel {
  final String clientSecret;
  final String ephemeralKeySecret;
  final String customerId;
  final String merchantDisplayName;

  InitPaymentSheetInputModel({required this.clientSecret, required this.ephemeralKeySecret, required this.customerId, required this.merchantDisplayName});
}