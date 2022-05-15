import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/firestore_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tagFirestoreProvider = Provider<TagFirestore>(
    (ref) => TagFirestore(firestore: ref.read(firestoreProvider)));

class TagFirestore {
  TagFirestore({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<Result<QuerySnapshot<Map<String, dynamic>>>> fetchAllTags() async {
    final ref = _firestore.collection('tags');

    try {
      final snapshot = await ref.orderBy('name').get();
      return Success(snapshot);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
