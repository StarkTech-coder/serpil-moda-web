import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/service_model.dart';

// Provides a singleton instance of FirebaseFirestore across the app
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

// StreamProvider that listens to real-time updates from the 'services' collection
final servicesStreamProvider = StreamProvider<List<ServiceModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);

  // Map the snapshots from the Firestore collection to a list of ServiceModel objects
  return firestore.collection('services').snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => ServiceModel.fromFirestore(doc.data(), doc.id))
        .toList();
  });
});
