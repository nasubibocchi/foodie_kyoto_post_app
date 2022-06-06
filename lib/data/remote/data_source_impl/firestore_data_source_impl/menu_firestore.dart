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

  Future<Result<Map<String, dynamic>>> createMenu(
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
        'movies': menuData['movies'],
        'food_tags': menuData['food_tags'],
        'price': menuData['price'],
        'review': menuData['review'],
        'en_review': menuData['en_review'],
        'post_user': menuData['post_user'],
      });

      return Success(menuData);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<QuerySnapshot<Map<String, dynamic>>>> fetchShopMenus(
      {required String shopId}) async {
    final ref = _firestore.collection('shops').doc(shopId).collection('menus');

    try {
      final result = await ref.get();
      return Success(result);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
