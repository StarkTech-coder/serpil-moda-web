class GalleryModel {
  final String id;
  final String imageUrl;
  final String category; // Örn: Gelinlik, Kaftan, Abiye
  final bool
      isAsset; // Fotoğrafın yerel mi yoksa internetten mi olduğunu anlamak için

  GalleryModel({
    required this.id,
    required this.imageUrl,
    required this.category,
    this.isAsset = true, // Varsayılan olarak yerel (asset) kabul ediyoruz
  });

  factory GalleryModel.fromFirestore(Map<String, dynamic> json, String id) {
    String url = json['imageUrl']?.toString() ?? '';

    // Eğer url içinde parantez veya tırnak kaldıysa onları temizle
    url = url
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .trim();

    return GalleryModel(
      id: id,
      imageUrl: url,
      category: json['category']?.toString() ?? 'Genel',
      // Eğer url assets/ ile başlamıyorsa internetten çekmesi gerektiğini anlasın
      isAsset: url.startsWith('assets/'),
    );
  }
}
