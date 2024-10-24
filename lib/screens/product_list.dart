import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_provider.dart';
import 'product_detail.dart';


class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final filteredProducts = productProvider.products;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 50,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        productProvider.searchProducts(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 130,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#FASHION DAY',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '80% OFF',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Discover fashion that suits your style',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Check this out', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 30),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildIconWithLabel(Icons.category, 'Category'),
                    _buildIconWithLabel(Icons.flight, 'Flight'),
                    _buildIconWithLabel(Icons.receipt, 'Bill'),
                    _buildIconWithLabel(Icons.data_usage, 'Data Plan'),
                    _buildIconWithLabel(Icons.attach_money, 'Top Up'),
                  ],
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    product.image,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: Icon(
                                        product.isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: product.isFavorite ? Colors.red : Colors.grey,
                                      ),
                                      onPressed: () {
                                        Provider.of<ProductProvider>(context, listen: false)
                                            .toggleFavorite(product);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "\$${product.price}",
                                style: TextStyle(fontSize: 18, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}
