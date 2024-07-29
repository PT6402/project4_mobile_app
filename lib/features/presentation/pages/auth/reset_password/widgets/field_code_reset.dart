import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldCodeReset extends StatelessWidget {
  final TextEditingController controller;
  const FieldCodeReset({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 68,
      width: size.width / 5.5,
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: const TextStyle(fontSize: 15),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ),
    );
  }
}
