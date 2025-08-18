import 'package:flutter/material.dart';
import 'package:flutter_application_1/BLOC/Auth_Bloc/auth_bloc.dart';
import 'package:flutter_application_1/BLOC/Nav_Bloc/nav_bloc.dart';
import 'package:flutter_application_1/BLOC/cart_Bloc/cart_bloc.dart';
import 'package:flutter_application_1/BLOC/home_bloc/home_bloc.dart';
import 'package:flutter_application_1/BLOC/order_bloc/order_bloc.dart';
import 'package:flutter_application_1/ColorScheme/app_theme.dart';

import 'package:flutter_application_1/representation/Authentication/Login.dart';

import 'package:flutter_application_1/representation/pages/HomeMain.dart';

import 'package:flutter_application_1/utility/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that the Flutter engine is initialized before running the app
  await Supabase.initialize(anonKey: Supabase_anonKey, url: Supabase_url);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
        BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
        BlocProvider<OrderBloc>(create: (_) => OrderBloc()),
        BlocProvider<NavBloc>(create: (_) => NavBloc()),
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: blinkitTheme,
      themeMode: ThemeMode.dark,
      home: session != null ? Homemain() : LoginPage(),
    );
  }
}
