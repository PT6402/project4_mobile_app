import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:testtem/Providers/BookProvider.dart';
import 'package:testtem/Providers/MyBookProvider.dart';
import 'package:testtem/Providers/OrderProvider.dart';
import 'package:testtem/Providers/ReadProvider.dart';
import 'package:testtem/Providers/WishlistProvider.dart';
import 'package:testtem/config/routers/router_provider.dart';
import 'package:testtem/core/constants/constant_url.dart';
import 'package:testtem/features/injection_container.dart';
import 'package:testtem/features/presentation/bloc/auth/auth_bloc.dart';

import 'Providers/CartProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setup();
  await init();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => sl<AuthBloc>()),
      ChangeNotifierProvider(create: (_) => BookProvider()),
      ChangeNotifierProvider(create: (_)=>WishListProvider(sl())),
      ChangeNotifierProvider(create: (_) => CartProvider(sl())),
      ChangeNotifierProvider(create: (_) => OrderProvider(sl())),
        ChangeNotifierProvider(create: (_) => MyBookProvider(sl())),
          ChangeNotifierProvider(create: (_) => ReadProvider(sl())),
    ], child: const MyApp()),
  );
}

Future<void> _setup() async {
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings(); // Add this line to ensure settings are applied
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'The book shelf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: RouterProvider.router,
    );
  }
}
