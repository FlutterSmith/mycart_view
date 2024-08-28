import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/repos/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());

  final CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentIntentInputModel paymentiIntentInputModel}) async {
    emit(PaymentLoading());
    var data = await checkoutRepo.makePayment(
        paymentiIntentInputModel: paymentiIntentInputModel);

    data.fold((l) => emit(PaymentFailure(l.errMessage)),
        (r) => emit(PaymentSuccess()));
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
