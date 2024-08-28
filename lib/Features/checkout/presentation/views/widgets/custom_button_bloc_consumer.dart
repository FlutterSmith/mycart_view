import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment/Features/checkout/presentation/manger/cubit/payment_cubit.dart';
import 'package:checkout_payment/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:checkout_payment/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        } else if (state is PaymentFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMessage),
          ));
        }
      },
      builder: (context, state) {
        return CustomButton(
            onTap: () {
              BlocProvider.of<PaymentCubit>(context).makePayment(
                paymentiIntentInputModel: PaymentIntentInputModel(
                  amount: '100',
                  currency: 'USD',
                  customer: 'cus_Qk2vdQJw3AJjKg',
                ),
              );
            },
            isLoading: state is PaymentLoading ? true : false,
            text: 'Continue');
      },
    );
  }
}
