import 'package:flutter/material.dart';
import 'package:shop_app/pages/product_details.dart';
import 'package:shop_app/providers/cart_povider.dart';
import 'package:shop_app/schemas.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.product,
      required this.isEven,
      required this.cartProvider});
  final Product product;
  final bool isEven;
  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: !isEven ? Theme.of(context).primaryColorLight : null,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: decoration,
        width: width * 0.9,
        height: height * 0.4,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  product: product,
                  provider: cartProvider,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '\$${product.price.toString()}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Expanded(
                  child: Center(
                    child: Image(
                      image: NetworkImage(product.image),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
