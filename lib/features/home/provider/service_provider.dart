import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/service_model.dart';

// Firestore instance'ını sağlayan provider
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

// Hizmetleri çeken asenkron provider
final servicesStreamProvider = StreamProvider<List<ServiceModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);

  // 'services' koleksiyonunu dinle
  return firestore.collection('services').snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => ServiceModel.fromFirestore(doc.data(), doc.id))
        .toList();
  });
});
