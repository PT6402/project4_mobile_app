import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:logger/logger.dart';
import 'package:testtem/Providers/CartProvider.dart';
import 'package:testtem/core/constants/constant_url.dart';

class StripeService {
  StripeService._();

  Logger logger = Logger();
  static final StripeService instance = StripeService._();

  static const String apiUrlCreatePaymentIntent =
      "$urlServer/api/v1/orders/create-payment-intent";

  Future<void> makePayment(int cartId, CartProvider cartProvider) async {
    try {
      // Step 1: Get the access token from the CartProvider via StorageToken
      final accessToken = await cartProvider.bearerToken.getAccessToken();

      // Step 2: Create Payment Intent on Backend
      Map<String, dynamic>? paymentData = await _createPaymentIntentOnBackend(cartId, accessToken!);
      if (paymentData == null) return;

      String paymentIntentClientSecret = paymentData['clientSecret'];
      int orderId = paymentData['orderId'];

      // Step 3: Initialize the Stripe Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "The Book Shelf",
        ),
      );

      // Step 4: Process the payment
      await _processPayment(cartProvider, orderId);
    } catch (e) {
      print('Error in makePayment: $e');
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntentOnBackend(int cartId, String accessToken) async {
    try {
      final Dio dio = Dio();

      // Making a POST request to your backend to create a PaymentIntent
      final response = await dio.post(
        '$apiUrlCreatePaymentIntent/$cartId',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Checking if the response is successful
      if (response.statusCode == 200) {
        // Return the response data containing clientSecret and orderId
        return response.data['model'] as Map<String, dynamic>;
      } else {
        print('Failed to create PaymentIntent: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error creating PaymentIntent on backend: $e');
      return null;
    }
  }

  Future<void> _processPayment(CartProvider cartProvider, int orderId) async {
    try {
      // Present payment sheet to user
      await Stripe.instance.presentPaymentSheet();

      logger.i('Payment sheet presented, checking payment status...');
      // After successful payment, call backend to confirm payment and update order status
      final paymentSuccess = await cartProvider.checkPayment(orderId);
      if (paymentSuccess) {
        cartProvider.clearCart(); // Clear the cart only if payment is successful
        logger.i('Payment successful and cart cleared');
      } else {
        logger.e('Payment failed or not completed.');
      }
    } catch (e) {
      logger.e('Error processing payment: $e');
    }
  }
}
