import 'package:flutter/material.dart';
import 'package:flutter_application_1/BLOC/Nav_Bloc/nav_bloc.dart';
import 'package:flutter_application_1/representation/pages/cart.dart';
import 'package:flutter_application_1/representation/pages/home.dart';
import 'package:flutter_application_1/representation/pages/orderPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Homemain extends StatefulWidget {
  const Homemain({super.key});

  @override
  State<Homemain> createState() => _HomemainState();
}

class _HomemainState extends State<Homemain> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [const Home(), const OrderPage(), const Cart()];

    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.index, children: pages),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: GNav(
                gap: 8,
                rippleColor: Colors.grey[200]!,
                hoverColor: Colors.grey[100]!,
                color: Colors.black,
                activeColor: Colors.white,
                iconSize: 24,
                tabBackgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                duration: const Duration(milliseconds: 400),
                selectedIndex: state.index,
                onTabChange: (index) {
                  context.read<NavBloc>().add(ChangeTabEvent(index));
                },
                tabs: const [
                  GButton(icon: Icons.home_rounded, text: 'Home'),
                  GButton(icon: Icons.shopping_bag_rounded, text: 'Orders'),
                  GButton(icon: Icons.shopping_cart_rounded, text: 'Cart'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
