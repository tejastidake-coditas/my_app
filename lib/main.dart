import 'package:flutter/material.dart';
import 'package:my_app/core/di/injector.dart';
import 'package:my_app/feature/product_listing/presentation/screens/listing_screen.dart';

void main() {
  Injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListingScreen(),
    );
  }
}
