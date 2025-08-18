import 'package:flutter/material.dart';
import 'package:flutter_application_1/BLOC/cart_Bloc/cart_bloc.dart';
import 'package:flutter_application_1/BLOC/order_bloc/order_bloc.dart';
import 'package:flutter_application_1/ColorScheme/app_theme.dart';
import 'package:flutter_application_1/representation/pages/orderPage.dart';
import 'package:flutter_application_1/utility/const.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(cartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      listener: (context, state) {
        if (state is cartUpdateState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Cart updated.")));
        }
      },
      builder: (context, state) {
        if (state is cartLoadingState) {
          return Scaffold(
            backgroundColor: blinkitTheme.scaffoldBackgroundColor,

            body: Center(child: Image.network(appbarImg)),
          );
        } else if (state is cartUpdateState) {
          final cartItems = state.cartItems;

          // ✅ Calculate total price
          final totalPrice = cartItems.fold<double>(
            0.0,
            (sum, item) => sum + (item.price),
          );

          return Scaffold(
            backgroundColor: blinkitTheme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(
                "Cart",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              backgroundColor: blinkitTheme.primaryColor,
            ),
            body:
                cartItems.isEmpty
                    ? Center(
                      child: Lottie.asset(
                        "assets/animations/Empty box.json",
                        height: 200,
                        width: 200,
                      ),
                    )
                    : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final product = cartItems[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    context.read<OrderBloc>().add(
                                      loadOrderEvent(Orderproduct: product),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (BuildContext context) =>
                                                OrderPage(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 8,
                                    color: blinkitTheme.cardColor,
                                    shadowColor: blinkitTheme.shadowColor,
                                    child: ListTile(
                                      leading: Image.network(
                                        product.thumbnail,
                                        width: 70,
                                        height: 90,
                                        fit: BoxFit.fill,
                                      ),
                                      title: Text(product.title, maxLines: 1),
                                      subtitle: Text("\$${product.price}"),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.remove_shopping_cart,
                                          size: 35,
                                        ),
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                            RemoveProductToCartEvent(
                                              product: product,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // ✅ Total price + Checkout Button
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(
                                  context,
                                ).bottomNavigationBarTheme.backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total: \$${totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 236, 60, 48),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text("Cart")),
            body: const Center(child: Text("Something went wrong")),
          );
        }
      },
    );
  }
}
