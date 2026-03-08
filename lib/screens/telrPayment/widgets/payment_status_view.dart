import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentStatusView extends StatelessWidget {
  final bool isPaymentSuccess;
  const PaymentStatusView({super.key, this.isPaymentSuccess = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        children: [
          Text(
            isPaymentSuccess ? 'Payment Success!!' : 'Payment Failed !!',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset(
              isPaymentSuccess
                  ? 'assets/animatedIcons/payment_success.json'
                  : 'assets/animatedIcons/payment_failed.json',
            ),
          ),
        ],
      ),
    );
  }
}
