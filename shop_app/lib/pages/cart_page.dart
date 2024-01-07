import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_povider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart Page'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartList = cartProvider.cartList;

          if (cartList.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }

          return ListView.builder(
            itemCount: cartList.length,
            itemBuilder: (context, index) {
              final product = cartList[index];
              return ListTile(
                tileColor:
                    index % 2 == 0 ? Theme.of(context).primaryColorLight : null,
                title: Text(
                  product.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: Image(
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      image: NetworkImage(product.image),
                    ),
                  ),
                ),
                subtitle: Text('\$${product.price.toString()}'),
                trailing: IconButton(
                  color: Colors.red,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteDialogue(context, cartProvider, product);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<dynamic> _deleteDialogue(
      BuildContext context, CartProvider cartProvider, product) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Remove Product',
            textAlign: TextAlign.center,
          ),
          content: const Text(
              'Are you sure you want to remove this product from cart'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                cartProvider.removeProduct(product);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
