// import 'package:flutter/material.dart';

// class PopupMenuWithArrow extends StatelessWidget {
//   final VoidCallback onCart;
//   final VoidCallback onOrder;
//   final VoidCallback onAboutUs;

//   PopupMenuWithArrow({
//     required this.onCart,
//     required this.onOrder,
//     required this.onAboutUs,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: PopupArrowPainter(),
//       child: Material(
//         color: Colors.white,
//         elevation: 4.0,
//         child: Container(
//           width: 200,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.shopping_cart),
//                 title: Text('Cart'),
//                 onTap: onCart,
//               ),
//               ListTile(
//                 leading: Icon(Icons.receipt),
//                 title: Text('Order'),
//                 onTap: onOrder,
//               ),
//               ListTile(
//                 leading: Icon(Icons.info),
//                 title: Text('About Us'),
//                 onTap: onAboutUs,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PopupArrowPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
    
//     final path = Path()
//       ..moveTo(0, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(0, size.height)
//       ..close();

//     final arrowPath = Path()
//       ..moveTo(size.width / 2 - 10, size.height)
//       ..lineTo(size.width / 2 + 10, size.height)
//       ..lineTo(size.width / 2, size.height + 10)
//       ..close();

//     canvas.drawPath(path, paint);
//     canvas.drawPath(arrowPath, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
