import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_event.dart';
import 'package:testtem/features/presentation/pages/auth/components/already_account.dart';
import 'package:testtem/features/presentation/pages/auth/components/or_divider.dart';
import 'package:testtem/features/presentation/pages/auth/components/socal_icon.dart';
import 'package:testtem/features/presentation/pages/auth/register_password/widgets/background_register.dart';
import 'package:testtem/features/presentation/pages/auth/register_password/widgets/form_register.dart';

class BodyRegister extends StatelessWidget {
  const BodyRegister({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    loginGG() {
      BlocProvider.of<AuthBloc>(context).add(LoginGGUser(context));
    }

    return BackgroundRegister(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          const FormRegister(),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyAccount(
            press: () => context.pushNamed("login"),
            login: false,
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
    ));
  }
}
