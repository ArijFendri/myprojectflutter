import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/product_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product, Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Initialiser l'état de favoris à partir du produit
    isFavorite = widget.product.isFavorite;
  }

  void toggleFavorite() {
    
    setState(() {
      isFavorite = !isFavorite;
      widget.product.isFavorite = isFavorite;
    });
   
    Provider.of<ProductProvider>(context, listen: false).toggleFavorite(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5, 
        toolbarHeight: 80, 
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
            onPressed: () {
             
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share, color: Colors.black), onPressed: () {}),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: toggleFavorite, 
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                     
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        
                          Expanded(
                            flex: 2, 
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                widget.product.image,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10), 

                          
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                _buildThumbnail(widget.product.image),
                                const SizedBox(height: 10), // Espacement entre les miniatures
                                _buildThumbnail(widget.product.image),
                                const SizedBox(height: 10),
                                _buildThumbnail(widget.product.image),
                                const SizedBox(height: 10),
                                _buildThumbnail(widget.product.image),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      // Titre du produit
                      Text(
                        widget.product.title,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'tokobaju.id',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),

                      // Informations sur le produit (évaluations, ventes)
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            "${widget.product.rating} Ratings",
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(width: 10),
                          const Text("2.3k+ Reviews", style: TextStyle(fontSize: 14, color: Colors.black54)),
                          const SizedBox(width: 10),
                          const Text("2.9k+ Sold", style: TextStyle(fontSize: 14, color: Colors.black54)),
                        ],
                      ),

                      // Onglets pour afficher plus d'infos (description ou avis)
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor: Colors.green,
                              unselectedLabelColor: Colors.black54,
                              indicatorColor: Colors.green,
                              tabs: const [Tab(text: 'About Item'), Tab(text: 'Reviews')],
                            ),
                            SizedBox(
                              height: 150,
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.product.description,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const Center(child: Text('Reviews Section')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoTile('Brand', 'ChArmkpR'),
                          _buildInfoTile('Color', 'Aprikot'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
           
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Total Price', style: TextStyle(fontSize: 14, color: Colors.black54)),
                        SizedBox(height: 5),
                        Text(
                          '\$18.00',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.shopping_bag_outlined, color: Colors.green),
                              SizedBox(width: 8),
                              Text('1', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                           
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Product purchased!')),
                            );
                          },
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour générer les miniatures à partir de l'image principale
  Widget _buildThumbnail(String imageUrl) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        widthFactor: 0.5, // Facteur de redimensionnement horizontal
        heightFactor: 0.5, // Facteur de redimensionnement vertical
        child: Image.network(
          imageUrl,
          height: 80, // Hauteur des miniatures
          width: 80,  // Largeur des miniatures
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Widget pour afficher les infos additionnelles sous forme de tuiles
  Widget _buildInfoTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
