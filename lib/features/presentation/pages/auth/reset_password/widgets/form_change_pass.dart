import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_button.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_password_field.dart';

class FormChangePass extends StatelessWidget {
  const FormChangePass({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    TextEditingController txtNewpassword = TextEditingController();
    Size size = MediaQuery.of(context).size;
    onSubmit() {
      if (keyForm.currentState!.validate()) {
        final value = txtNewpassword.text;
        final code = BlocProvider.of<AuthBloc>(context).state.code!;
        BlocProvider.of<AuthBloc>(context)
            .add(ResetPasswordUser((code: code, newPassword: value), context));
      }
    }

    return Form(
        key: keyForm,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            RoudedPasswordField(
              hintText: "new password",
              controller: txtNewpassword,
              validate: (value) {
                if (value!.isEmpty) {
                  return "is required";
                }
                return null;
              },
            ),
            RoudedPasswordField(
              hintText: "confirm password",
              controller: txtNewpassword,
              validate: (value) {
                if (value!.isEmpty) {
                  return "is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoudedButton(
              text: "Reset",
              press: onSubmit,
              textColor: Colors.white,
            ),
          ],
        ));
  }
}
