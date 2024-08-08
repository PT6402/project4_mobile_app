import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/CartProvider.dart';
import 'package:testtem/services/stripe_service.dart';
import '../Widgets/cart_item.dart';
import '../DTO/CartItemShow.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotalPrice() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double totalPrice = 0.0;
    for (var item in cartProvider.cartItems) {
      if (item.ibuy) {
        totalPrice += item.priceBuy;
      } else {
        final selectedPackage = item.packlist.firstWhere(
              (pack) => pack.id == item.packId,
          orElse: () => PackageShowbook(
            id: 0,
            packageName: "Default",
            dayQuantity: 0,
            rentPrice: 0.0,
          ),
        );
        totalPrice += selectedPackage.rentPrice;
      }
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Container(
                height: size.height * 0.6,
                child: ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return CartItem(cartItem: cartItem);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total: \$${calculateTotalPrice()}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final cartId = cartProvider.cartItems.isNotEmpty ? cartProvider.cartItems.first.cartId : 0;

                        if (cartId > 0) {
                          await StripeService.instance.makePayment(cartId, cartProvider);
                        } else {
                          print("Cart ID is not valid.");
                        }
                      },
                      child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
