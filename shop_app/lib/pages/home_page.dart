import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/product_selection_page.dart';
import 'package:shop_app/schemas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Product> productList;
  List<Widget> pageList = [];
  int currentIndex = 0;

  Future<void> fetchProduct() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse('https://fakestoreapi.com/products/'));
      if (response.statusCode == 200) {
        List<dynamic> productListJson = json.decode(response.body);
        pageList = [
          ProductListPage(
            products: productList,
          ),
          const CartPage()
        ];
        productList =
            productListJson.map((json) => Product.fromJson(json)).toList();
        setState(() {});
      } else {
        throw Exception('Failed to load products');
      }
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    super.initState();
    productList = [];
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "")
        ],
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchProduct(),
          builder: (context, snapshot) {
            if (productList.isEmpty &&
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: width * 0.3,
                  height: height * 0.2,
                  child: Lottie.asset('assets/animation/loader.json'),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error as String),
              );
            }
            return IndexedStack(index: currentIndex, children: pageList);
          },
        ),
      ),
    );
  }
}
