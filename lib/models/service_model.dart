class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.price = 0.0,
  });

  // Firestore'dan gelen veriyi modele dönüştürür
  factory ServiceModel.fromFirestore(Map<String, dynamic> json, String id) {
    return ServiceModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }

  // Gerekirse veriyi Map formatına dönüştürür
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
