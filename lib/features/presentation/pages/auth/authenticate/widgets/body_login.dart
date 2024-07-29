import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/pages/auth/authenticate/widgets/background_login.dart';
import 'package:testtem/features/presentation/pages/auth/authenticate/widgets/forgot_password_login.dart';
import 'package:testtem/features/presentation/pages/auth/components/already_account.dart';
import 'package:testtem/features/presentation/pages/auth/components/or_divider.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_button.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_input_field.dart';
import 'package:testtem/features/presentation/pages/auth/components/rounded_password_field.dart';
import 'package:testtem/features/presentation/pages/auth/components/socal_icon.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({super.key});

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    onSubmit() {
      if (keyForm.currentState!.validate()) {
        ({String email, String password}) value =
            (email: txtEmail.text, password: txtPassword.text);
        BlocProvider.of<AuthBloc>(context).add(LoginUser(value, context));
        txtEmail.clear();
        txtPassword.clear();
      }
    }

    loginGG() {
      BlocProvider.of<AuthBloc>(context).add(LoginGGUser(context));
    }

    return BackgroundLogin(
        child: SingleChildScrollView(
      child: Form(
        key: keyForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "LOGIN",
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
            RoudedPasswordField(
              hintText: "password",
              controller: txtPassword,
              validate: (value) {
                if (value!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            const ForgotPasswordLogin(),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoudedButton(
              text: "Login",
              press: onSubmit,
              textColor: Colors.white,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyAccount(
              press: () => context.pushNamed("register"),
            ),
            const OrDivider(),
            Center(
              child: SocalIcon(
                iconSrc: "assets/icons/google-icon.svg",
                press: loginGG,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
