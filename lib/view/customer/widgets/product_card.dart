import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.imageUrl.startsWith('http')
        ? product.imageUrl
        : 'https://tepdcxtlykiugezsaamc.supabase.co/storage/v1/object/public/product-images/${product.imageUrl}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 361,
        height: 131,
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(85.32),
              child: Image.network(
                imageUrl,
                width: 93,
                height: 93,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 93,
                  height: 93,
                  color: const Color(0xFFCCCCCC),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 93,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 219,
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Figtree',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 219,
                    child: Text(
                      'PHP${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Figtree',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 219,
                    child: Text(
                      product.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Figtree',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
