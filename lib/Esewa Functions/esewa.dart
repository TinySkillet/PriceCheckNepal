import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';

import 'package:price_check_np/Esewa%20Credentials/esewa.dart';

class Esewa {
  pay() {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: eEsewaClientId,
          secretId: eEsewaScrentKey,
        ),
        esewaPayment: EsewaPayment(
          productId: "1d71jd81",
          productName: "Product One",
          productPrice: "20",
          callbackUrl: "", // Callback URL to to notify the client payment result
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          debugPrint('PAYMENT SUCCESS');
          verify(result);
        },
        onPaymentFailure: () {
          debugPrint('PAYMENT FAIL');
        },
        onPaymentCancellation: () {
          debugPrint('PAYMENT CANCEL');
        },
      );
    } catch (e) {
      debugPrint('EXCEPTION');
    }
  }

  verify(EsewaPaymentSuccessResult result) {
    // Calling this function to verify transaction
  }
}