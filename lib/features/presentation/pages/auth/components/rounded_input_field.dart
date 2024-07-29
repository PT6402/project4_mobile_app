import 'package:flutter/material.dart';
import 'package:testtem/features/presentation/pages/auth/components/text_field_container.dart';

class RoudedInputField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? validate;
  final bool autoValid;
  const RoudedInputField({
    super.key,
    this.hintText,
    this.icon,
    this.onChange,
    this.controller,
    this.validate,
    this.autoValid = false,
  });

  @override
  State<RoudedInputField> createState() => _RoudedInputFieldState();
}

class _RoudedInputFieldState extends State<RoudedInputField> {
  String? messageError;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      messageError: messageError,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validate,
        onChanged: widget.onChange,
        decoration: InputDecoration(
            hintText: widget.hintText,
            icon: Icon(widget.icon, color: Colors.blueGrey),
            border: InputBorder.none),
        autovalidateMode: widget.autoValid
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
      ),
    );
  }
}
