import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_povider.dart';
import 'package:shop_app/schemas.dart';
import 'package:shop_app/widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key, required this.products});
  final List<Product> products;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<String> chipList = [
    "All",
    "Cloths",
    "Electronics",
    "Gadgets",
    "Fancy",
    "Bags"
  ];
  late String selectedChip;
  @override
  void initState() {
    selectedChip = chipList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return Column(
        children: [_searchBar(), _chipsSet(), _productList(cartProvider, size)],
      );
    });
  }

  Row _searchBar() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Products\nCollection",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(50)),
              ),
            ),
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        )
      ],
    );
  }

  _chipsSet() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: chipList.length,
          itemBuilder: (c, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedChip = chipList[i];
                  });
                },
                child: Chip(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  label: Text(
                    chipList[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: selectedChip == chipList[i]
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark,
                ),
              ),
            );
          }),
    );
  }

  _productList(CartProvider cartProvider, Size size) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 1080 ? 3 : 1,
                childAspectRatio: size.width > 1080 ? 1.2 : 1),
            itemCount: widget.products.length,
            itemBuilder: (c, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductCard(
                  product: widget.products[i],
                  isEven: i % 2 == 0 ? true : false,
                  cartProvider: cartProvider,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
