import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/gallery_model.dart';

final galleryStreamProvider = StreamProvider<List<GalleryModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('gallery')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => GalleryModel.fromFirestore(doc.data(), doc.id))
        .toList();
  });
});
