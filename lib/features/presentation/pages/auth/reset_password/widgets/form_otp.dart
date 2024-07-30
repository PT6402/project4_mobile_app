import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_button.dart';
import 'package:testtem/features/presentation/pages/auth/reset_password/widgets/field_code_reset.dart';

class FormOtp extends StatefulWidget {
  const FormOtp({super.key});

  @override
  State<FormOtp> createState() => _FormOtpState();
}

class _FormOtpState extends State<FormOtp> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController txtP1 = TextEditingController();
  TextEditingController txtP2 = TextEditingController();
  TextEditingController txtP3 = TextEditingController();
  TextEditingController txtP4 = TextEditingController();
  bool errorRequired = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    onSubmit() {
      if (txtP1.text.isNotEmpty &&
          txtP2.text.isNotEmpty &&
          txtP3.text.isNotEmpty &&
          txtP4.text.isNotEmpty) {
        String value = "${txtP1.text}${txtP2.text}${txtP3.text}${txtP4.text}";
        BlocProvider.of<AuthBloc>(context)
            .add(CheckCodeResetUser(value, context));
        txtP1.clear();
        txtP2.clear();
        txtP3.clear();
        txtP4.clear();
      } else {
        setState(() {
          errorRequired = true;
        });
      }
    }

    return Form(
      key: keyForm,
      onChanged: () => setState(() {
        errorRequired = false;
      }),
      child: Column(
        children: [
          const Text(
            "OTP VERIFICATION",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FieldCodeReset(controller: txtP1),
              FieldCodeReset(controller: txtP2),
              FieldCodeReset(controller: txtP3),
              FieldCodeReset(controller: txtP4),
            ],
          ),
          if (errorRequired)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "is required",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ],
            ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoudedButton(
            text: "Send",
            press: onSubmit,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
