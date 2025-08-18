import 'package:flutter/material.dart';
import 'package:flutter_application_1/BLOC/order_bloc/order_bloc.dart';
import 'package:flutter_application_1/ColorScheme/app_theme.dart';
import 'package:flutter_application_1/representation/pages/HomeMain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/productModel.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blinkitTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: blinkitTheme.appBarTheme.backgroundColor,
        foregroundColor: Colors.black87,
        elevation: 1,
        centerTitle: true,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is orderLoadedstate) {
            Product product = state.orderProduct;

            return Stack(
              children: [
                // Scrollable Content
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Card
                      Card(
                        color: blinkitTheme.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                product.thumbnail,
                                height: 240,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),

                                  const SizedBox(height: 2),
                                  Text(
                                    "Price: ₹${product.price}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Order Details Section
                      Text(
                        "Order Details",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFB9FBC0),
                              Color(0xFFFFFFFF),
                            ], // Mint Green → White
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _orderDetailRow(
                              "Product Price",
                              "\$${product.price}",
                              isBold: true,
                              valueColor: Color.fromARGB(255, 236, 60, 48),
                            ),
                            _orderDetailRow("Delivery Charges", "Free"),
                            _orderDetailRow("Discount", "- ₹0"),
                            const Divider(),
                            _orderDetailRow(
                              "Total",
                              "\$${product.price}",
                              isBold: true,
                              valueColor: Color.fromARGB(255, 236, 60, 48),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Fixed Total + Payment Button
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(
                            context,
                          ).bottomNavigationBarTheme.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "₹${product.price}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 236, 60, 48),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _OrderConfirmed(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              backgroundColor:
                                  blinkitTheme.bottomAppBarTheme.color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("No Order Yet"));
        },
      ),
    );
  }

  void _OrderConfirmed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order Confirmed 🎉"),
          content: Text("Your order has been placed successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const Homemain()),
                  (route) => false, // clear stack, go back to main
                ); // Go back to previous page
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _orderDetailRow(
    String label,
    String value, {
    bool isBold = false,
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 17 : 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
