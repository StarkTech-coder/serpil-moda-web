import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/gallery_model.dart';

// Provides a real-time stream of GalleryModel objects from the 'gallery' collection
final galleryStreamProvider = StreamProvider<List<GalleryModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('gallery')
      .snapshots()
      .map((snapshot) {
    // Mapping each Firestore document to a GalleryModel instance
    return snapshot.docs
        .map((doc) => GalleryModel.fromFirestore(doc.data(), doc.id))
        .toList();
  });
});
