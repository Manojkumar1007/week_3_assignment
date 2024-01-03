import 'package:flutter/material.dart';
import 'package:movies_app/models/wishlist.dart';
import 'package:movies_app/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Wishlist(),
      builder: (context,child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NETFLIX',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black12,
        ),
        home: const HomePage(),
      ),
    );
  }
}
