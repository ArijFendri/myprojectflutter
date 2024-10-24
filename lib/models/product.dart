class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final double rating;
  bool isFavorite;  

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    this.isFavorite = false, 
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['thumbnail'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      isFavorite: json['isFavorite'] ?? false, 
    );
  }
}