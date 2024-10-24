import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product_provider.dart';
import 'screens/product_list.dart'; 


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
          home: HomeScreen(), 
        ));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; 

  // Les différentes pages de l'application
  static List<Widget> _pages = <Widget>[
    ProductListScreen(), // Page pour afficher la liste des produits
    Center(
        child:
            Text('Voucher Page')), 
    Center(child: Text('Wallet Page')), 
    Center(child: Text('Settings Page')), 
  ];

  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, 
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, 
        selectedItemColor: Colors.green, 
        unselectedItemColor:
            Colors.grey, 
        showUnselectedLabels:
            true, 
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Section Accueil
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Voucher', // Section Bons de réduction
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet', // Section Portefeuille
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings', // Section Paramètres
          ),
        ],
      ),
    );
  }
}
