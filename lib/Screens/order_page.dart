// OrderPage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtem/DTO/Order.dart';
import 'package:testtem/Providers/OrderProvider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.getOrder().then((_) {
        debugOrderDetails(orderProvider.orderlist);
      });
    });
  }

  void debugOrderDetails(List<Order> orders) {
    for (var order in orders) {
      print('Order ID: ${order.orderId}');
      for (var detail in order.orderDetails) {
        print('Book Name: ${detail.bookName}');
      }
    }
  }

  void showReviewModal(BuildContext context, List<ReviewDetail> reviews, int bookId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reviews'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...reviews.map((review) => Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.all(8.0),
                constraints: BoxConstraints(
                  minHeight: 150,
                  minWidth: double.infinity, // Đặt chiều rộng tối đa của Container
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      rating: review.star,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(height: 4.0),
                    Text("Time Review:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(review.createDate),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Content:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(review.content),
                  ],
                ),
              )),
              SizedBox(height: 20.0), // Thêm khoảng cách dưới các review
              ElevatedButton(
                child: Text('New Review'),
                onPressed: () {
                  Navigator.of(context).pop();
                  showNewReviewModal(context, bookId); // Truyền bookId vào đây
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



 void showNewReviewModal(BuildContext context, int bookId) {
  double rating = 0;
  TextEditingController reviewController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Write a Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30.0,
              onRatingUpdate: (newRating) {
                rating = newRating;
              },
              ratingWidget: RatingWidget(
                full: Icon(Icons.star, color: Colors.amber),
                half: Icon(Icons.star_half, color: Colors.amber),
                empty: Icon(Icons.star_border, color: Colors.amber),
              ),
            ),
            SizedBox(height: 8.0),
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
              Navigator.of(context).pop();  // Đóng dialog
            },
          ),
          TextButton(
            child: Text('Submit'),
            onPressed: () async {
              final content = reviewController.text;
              if (content.isNotEmpty && rating > 0) {
                try {
                  final orderProvider = Provider.of<OrderProvider>(context, listen: false);
                  final message = await orderProvider.createReview(bookId, rating, content);

                    Navigator.of(context).pop();

                  // Đảm bảo snackbar được hiển thị sau khi dialog đóng
                  Future.delayed(Duration(milliseconds: 2), () {
                    if (ScaffoldMessenger.maybeOf(context) != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Review successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  });
                } catch (e) {
                

                  // Đóng dialog nếu xảy ra lỗi
                  Navigator.of(context).pop();

                  // Hiển thị snackbar lỗi nếu widget còn tồn tại
                  Future.delayed(Duration(milliseconds: 10), () {
                    if (ScaffoldMessenger.maybeOf(context) != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Your review contain forbidden words. Please re-write with positive comment'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
                }
              } else {
                Future.delayed(Duration(milliseconds: 10), () {
                    if (ScaffoldMessenger.maybeOf(context) != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('please fullfill review content'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
              }
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
                subtitle: Text(
                    'Payment Status: ${order.paymentStatus ? 'Paid' : 'Unpaid'}'),
                children: order.orderDetails.isNotEmpty
                    ? order.orderDetails.map((detail) {
                        return ListTile(
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.grey[300],
                                ),
                                child: detail.image.isNotEmpty
                                    ? Image.memory(detail.image, fit: BoxFit.cover)
                                    : Center(
                                        child: Text(
                                          'No Image',
                                          style: TextStyle(color: Colors.grey[600]),
                                        ),
                                      ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${detail.bookName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    // Text("Id: ${detail.bookId}"),
                                    SizedBox(height: 5),
                                    Text(
                                      'Price: \$${detail.price}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Day Package: ${detail.dayPackage}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(height: 5),
                                    if (detail.packName != null)
                                      Text(
                                        'Package Name: ${detail.packName}',
                                        style: TextStyle(color: Colors.grey[600]),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    child: Text('View Reviews'),
                                    onPressed: () {
                                      showReviewModal(context, detail.reviews, detail.bookId);
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    child: Text('New Review'),
                                    onPressed: () {
                                      showNewReviewModal(context, detail.bookId);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList()
                    : [Center(child: Text('No details available'))],
              ),
            );
          },
        );
      },
    ),
  );
}

}
