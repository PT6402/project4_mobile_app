import 'package:flutter/material.dart';

class TextFieldContainer extends StatefulWidget {
  final Widget child;
  final String? messageError;
  const TextFieldContainer({super.key, required this.child, this.messageError});

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.8,
          margin: const EdgeInsets.only(top: 10, bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15)),
          child: widget.child,
        ),
        if (widget.messageError != null)
          Container(
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(top: 0),
            child: Text("${widget.messageError}"),
          )
      ],
    );
  }
}
