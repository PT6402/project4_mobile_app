import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/CartProvider.dart';

import '../DTO/CartItemShow.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartItem});

  final CartItemShow cartItem;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Logger logger = Logger();
  PackageShowbook? selectedPackage;

  void handleChangeValue(value) {
    setState(() {
      if (value != null) {
        final package =
            widget.cartItem.packlist.firstWhere((PackageShowbook p) {
          return p.id == value.id;
        });
        logger.i(package);
        selectedPackage = package;
      } else {
        selectedPackage = null;
      }
      logger.i(selectedPackage?.packageName);
      // selectedPackage = value;
      // cartProvider.selectedPackage = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.cartItem.ibuy == false) {
      final package = widget.cartItem.packlist.firstWhere((PackageShowbook p) {
        return p.id == widget.cartItem.packId;
      });
      logger.i(package);
      selectedPackage = package;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.memory(
              base64Decode(widget.cartItem.imageData),
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartItem.bookName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<PackageShowbook>(
                      hint: const Text('Select an option'),
                      // value: selectedPackage,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem<PackageShowbook>(
                          value: null,
                          child: Text('Buy - \$${widget.cartItem.priceBuy}'),
                        ),
                        ...widget.cartItem.packlist
                            .map((PackageShowbook package) {
                          return DropdownMenuItem<PackageShowbook>(
                            value: package,
                            child: Text(
                              '${package.packageName} - \$${package.rentPrice} for ${package.dayQuantity} days',
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ],
                      selectedItemBuilder: (BuildContext context) {
                        print('Selected: ${selectedPackage?.packageName}');
                        return [
                          selectedPackage == null
                              ? Text('Buy - \$${widget.cartItem.priceBuy}')
                              : Text(
                                  '${selectedPackage?.packageName} - \$${selectedPackage?.rentPrice} for ${selectedPackage?.dayQuantity} days')
                        ];
                      },
                      onChanged: (value) {
                        handleChangeValue(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await cartProvider.removeFromCart(widget.cartItem.bookId);
                setState(() {
                  // Refresh the cart page after deletion
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
