import 'package:flutter/material.dart';
import 'package:testtem/themes/light_color.dart';
import 'package:testtem/themes/theme.dart';

import '../Widgets/tile_text.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  Widget _orderItems() {
    return Column(
      children: [
        _item(
          name: 'Book 1',
          price: 29.99,
          quantity: 1,
          image: 'assets/book1.jpg', // Replace with your image path
        ),
        _item(
          name: 'Book 2',
          price: 49.99,
          quantity: 2,
          image: 'assets/book2.jpg', // Replace with your image path
        ),
      ],
    );
  }

  Widget _item({required String name, required double price, required int quantity, required String image}) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Image.asset(image),
                )
              ],
            ),
          ),
          Expanded(
            child: ListTile(
              title: TitleText(
                text: name,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              subtitle: Row(
                children: <Widget>[
                  TitleText(
                    text: '\$ ',
                    color: LightColor.red,
                    fontSize: 12,
                  ),
                  TitleText(
                    text: price.toString(),
                    fontSize: 14,
                  ),
                ],
              ),
              trailing: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: LightColor.lightGrey.withAlpha(150),
                    borderRadius: BorderRadius.circular(10)),
                child: TitleText(
                  text: 'x$quantity',
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleText(
          text: '2 Items',
          color: LightColor.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        TitleText(
          text: '\$129.97',
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Implement the order submission logic
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 4),
        width: AppTheme.fullWidth(context) * .75,
        child: TitleText(
          text: 'Place Order',
          color: LightColor.background,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
      ),
      body: Container(
        padding: AppTheme.padding,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _orderItems(),
              Divider(
                thickness: 1,
                height: 70,
              ),
              _price(),
              SizedBox(height: 30),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
