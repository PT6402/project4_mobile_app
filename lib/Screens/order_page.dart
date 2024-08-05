import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/Order.dart';
import 'package:testtem/Providers/OrderProvider.dart';


class OrderPage extends StatefulWidget {
  OrderPage({super.key});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).getOrder();
    });
  }

  void showReviewModal(BuildContext context, ReviewDetail review) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = review.star;
        TextEditingController reviewController = TextEditingController(text: review.content);

        return AlertDialog(
          title: Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              TextField(
                controller: reviewController,
                decoration: InputDecoration(hintText: 'Write your review here'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                // Xử lý logic submit đánh giá ở đây
                setState(() {
                  review.setStar(rating);
                  review.setContent(reviewController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order History')),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.orderlist.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: orderProvider.orderlist.length,
            itemBuilder: (context, index) {
              Order order = orderProvider.orderlist[index];
              return Card(
                child: ExpansionTile(
                  title: Text('Order ID: ${order.orderId}'),
                  subtitle: Text('Payment Status: ${order.paymentStatus ? 'Paid' : 'Unpaid'}'),
                  children: order.orderDetails.map((detail) {
                    return ListTile(
                      title: Text('Book Name: ${detail.bookName}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Book ID: ${detail.bookId}'),
                          Text('Price: \$${detail.price}'),
                          Text('Day Package: ${detail.dayPackage} days'),
                          Text('Pack ID: ${detail.packId}'),
                          Text('Pack Name: ${detail.packName}'),
                          Image.memory(detail.image),
                          ElevatedButton(
                            child: Text('Review'),
                            onPressed: () {
                              showReviewModal(context, detail.review);
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
