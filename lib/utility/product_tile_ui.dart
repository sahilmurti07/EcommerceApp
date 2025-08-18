import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/productModel.dart';
import 'package:flutter_application_1/BLOC/home_bloc/home_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTileUi extends StatelessWidget {
  final Product product;
  final HomeBloc homebloc;

  const ProductTileUi({
    super.key,
    required this.product,
    required this.homebloc,
  });

  @override
  Widget build(BuildContext context) {
    // 🎨 Pastel color palette
    final List<Color> colors = [
      Color(0xFFFFF3E0), // Soft Peach
      Color(0xFFE3F2FD), // Baby Blue
      Color(0xFFE8F5E9), // Mint Green
      Color(0xFFFFF9C4), // Light Yellow
      Color(0xFFF3E5F5), // Lavender
      Color(0xFFFFEBEE), // Rose Pink
    ];

    // Pick color based on product ID hash (so it’s always consistent)
    final cardColor = colors[product.id % colors.length];

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        homebloc.add(NavigateToDetailPageEvent(product));
      },
      child: Container(
        width: 200,
        height: 150,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cardColor, // 🔹 Dynamic color instead of appTheme.cardColor
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 90,
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "\$${product.price}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_circle_right, size: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
