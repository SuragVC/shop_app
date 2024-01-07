import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/home_page.dart';
import 'package:shop_app/providers/cart_povider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ], child: const HomePage()),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(223, 1, 0, 2),
          primary: const Color.fromARGB(224, 31, 1, 122),
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
