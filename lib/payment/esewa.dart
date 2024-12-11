import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import 'package:price_check_np/utils/utils.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:http/http.dart' as http;

class EsewaPaymentGateway {
  final int amount;
  final BuildContext context;
  const EsewaPaymentGateway({
    required this.amount,
    required this.context,
  });

  void _showPaymentAlert({
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorLight,
          title: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void InitiatePayment() {
    const CLIENT_ID = "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R";
    const SECRET_KEY = "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==";
    String productId = Utils.generateDonationId();
    String productName = "PriceCheck Nepal Donation";

    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          clientId: CLIENT_ID,
          secretId: SECRET_KEY,
          environment: Environment.test,
        ),
        esewaPayment: EsewaPayment(
          productId: productId,
          productName: productName,
          productPrice: amount.toString(),
          callbackUrl: "", // add appropriate url here in future
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          log(":::SUCCESS::: => $data");
          verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          log(":::FAILURE::: => $data");
          _showPaymentAlert(
              title: 'Payment Failed',
              message: 'Your payment could not be processed. Please try again.',
              isSuccess: false);
        },
        onPaymentCancellation: (data) {
          log(":::CANCELLATION::: => $data");
          _showPaymentAlert(
              title: 'Payment Cancelled',
              message: 'Payment was cancelled.',
              isSuccess: false);
        },
      );
    } on Exception catch (e) {
      log("EXCEPTION: ${e.toString()}");
      _showPaymentAlert(
          title: 'Payment Error',
          message: 'An unexpected error occurred: ${e.toString()}',
          isSuccess: false);
    }
  }

  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
    const MERCHANT_ID = "EPAYTEST";
    const MERCHANT_SECRET = "8gBm/:&EnhH.1/q";
    String URL =
        "https://rc.esewa.com.np/mobile/transaction?txnRefId=${result.refId}";
    var url = Uri.parse(URL);
    var headers = {
      'merchantId': MERCHANT_ID,
      'merchantSecret': MERCHANT_SECRET,
      'Content-Type': 'application/json',
    };

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody[0]['transactionDetails']['status'] == 'COMPLETE') {
          log('Transaction is complete!');
          _showPaymentAlert(
              title: 'Payment Successful',
              message:
                  'Your donation of $amount has been processed successfully.',
              isSuccess: true);
        } else {
          log('Transaction is not complete!');
          _showPaymentAlert(
              title: 'Transaction Incomplete',
              message: 'Your transaction could not be completed!',
              isSuccess: false);
        }
      } else {
        log('Failed to verify transaction: ${response.statusCode}');
        _showPaymentAlert(
            title: 'Verification Failed',
            message:
                'Unable to verify your transaction. Please check your connection and try again.',
            isSuccess: false);
      }
    } catch (e) {
      log('Exception in transaction verification: ${e.toString()}');
      _showPaymentAlert(
          title: 'Verification Error',
          message: 'An error occurred while verifying your transaction.',
          isSuccess: false);
    }
  }
}
