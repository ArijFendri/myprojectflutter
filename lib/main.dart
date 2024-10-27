import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product_provider.dart';
import 'screens/product_list.dart';
import 'screens/home_screen.dart'; // Ajout de l'import du fichier HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'CustomFont',
        ),
        home: HomeScreen(), // HomeScreen dans le fichier séparé
      ),
    );
  }
}
