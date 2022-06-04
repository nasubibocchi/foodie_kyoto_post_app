import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/firestore_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final menuFirestoreProvider = Provider<MenuFirestore>(
    (ref) => MenuFirestore(firestore: ref.read(firestoreProvider)));

class MenuFirestore {
  MenuFirestore({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<Result<Map<String, dynamic>>> postMenu(
      {required Map<String, dynamic> menuData}) async {
    final ref = _firestore
        .collection('shops')
        .doc(menuData['shop_id'])
        .collection('menus');

    try {
      await ref.add(<String, dynamic>{
        'name': menuData['name'],
        'shop_id': menuData['shop_id'],
        'images': menuData['images'],
        'food_tags': menuData['food_tags'],
        'price': menuData['price'],
        'review': menuData['review'],
      });

      return Success(menuData);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
