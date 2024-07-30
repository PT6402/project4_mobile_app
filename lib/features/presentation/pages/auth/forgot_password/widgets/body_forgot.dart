import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_state.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_button.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_input_field.dart';
import 'package:testtem/features/presentation/pages/auth/forgot_password/widgets/background_forgot.dart';

class BodyForgot extends StatelessWidget {
  const BodyForgot({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    TextEditingController txtEmail = TextEditingController();
    Size size = MediaQuery.of(context).size;

    onSubmit() {
      if (keyForm.currentState!.validate()) {
        var value = txtEmail.text;

        BlocProvider.of<AuthBloc>(context)
            .add(ForgotPasswordUser(value, context));
      }
    }

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return BackgroundForgot(
          child: Form(
        key: keyForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "FORGOT PASSWORD",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoudedInputField(
              hintText: "email",
              icon: IconlyLight.profile,
              controller: txtEmail,
              validate: (value) {
                if (value!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoudedButton(
              text: state.isLoading != null
                  ? state.isLoading!
                      ? null
                      : "Send"
                  : "Send",
              press: onSubmit,
              textColor: Colors.white,
            ),
          ],
        ),
      ));
    });
  }
}
