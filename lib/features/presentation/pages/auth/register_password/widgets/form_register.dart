import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_button.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_input_field.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_password_field.dart';

class FormRegister extends StatelessWidget {
  const FormRegister({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    final TextEditingController txtEmail = TextEditingController();
    final TextEditingController txtName = TextEditingController();
    final TextEditingController txtPassword = TextEditingController();
    Size size = MediaQuery.of(context).size;

    onSubmit() {
      if (keyForm.currentState!.validate()) {
        ({
          String name,
          String email,
          String password,
        }) value = (
          name: txtName.text,
          email: txtEmail.text,
          password: txtPassword.text,
        );
        BlocProvider.of<AuthBloc>(context).add(RegisterUser(value, context));
      }
    }

    return Form(
        key: keyForm,
        child: Column(
          children: [
            RoudedInputField(
              controller: txtName,
              hintText: "name",
              icon: IconlyLight.profile,
              validate: (value) {
                if (value!.isEmpty) {
                  return "is required";
                }
                return null;
              },
            ),
            RoudedInputField(
              controller: txtEmail,
              hintText: "email",
              icon: IconlyLight.profile,
              validate: (value) {
                if (value!.isEmpty) {
                  return "is required";
                }
                return null;
              },
            ),
            RoudedPasswordField(
              hintText: "password",
              controller: txtPassword,
              validate: (value) {
                if (value!.isEmpty) {
                  return "is required";
                }
                return null;
              },
            ),
            RoudedPasswordField(
              hintText: "confirm password",
              controller: txtPassword,
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
              text: "Sign up",
              press: onSubmit,
              textColor: Colors.white,
            ),
          ],
        ));
  }
}
