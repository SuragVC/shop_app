import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_povider.dart';
import 'package:shop_app/schemas.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage(
      {super.key, required this.product, required this.provider});
  final Product product;
  final CartProvider provider;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _productDisplayCard(context, width, height),
            _cartItemCard(height, context, widget.provider)
          ],
        ),
      ),
    );
  }

  Expanded _productDisplayCard(
      BuildContext context, double width, double height) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            widget.product.title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 9,
            child: Image(
              image: NetworkImage(widget.product.image),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _cartItemCard(
      double height, BuildContext context, CartProvider cartProvider) {
    Product product = widget.product;
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$ ${product.price}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Text(
                  product.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rating :${product.rating.rate}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart,
                            color: Theme.of(context).canvasColor),
                        const SizedBox(width: 8),
                        Text("Add To Cart",
                            style: Theme.of(context).textTheme.titleMedium)
                      ],
                    ),
                    onPressed: () {
                      cartProvider.setProductToCart(product);
                      awesomeTopSnackbar(context, "Product Added to cart");
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
