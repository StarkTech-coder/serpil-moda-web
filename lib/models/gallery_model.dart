class GalleryModel {
  final String id;
  final String imageUrl;
  final String category; // e.g., Bridal, Kaftan, Evening Dress
  final bool
      isAsset; // Flag to determine if the image is stored locally or online

  GalleryModel({
    required this.id,
    required this.imageUrl,
    required this.category,
    this.isAsset = true, // Defaults to local asset
  });

  // Factory constructor to create a GalleryModel from Firestore data
  factory GalleryModel.fromFirestore(Map<String, dynamic> json, String id) {
    String url = json['imageUrl']?.toString() ?? '';

    // Sanitizing the URL by removing unwanted brackets or parentheses
    url = url
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .trim();

    return GalleryModel(
      id: id,
      imageUrl: url,
      category: json['category']?.toString() ?? 'General',
      // Automatically determine if the path points to a local asset or a network URL
      isAsset: url.startsWith('assets/'),
    );
  }
}
