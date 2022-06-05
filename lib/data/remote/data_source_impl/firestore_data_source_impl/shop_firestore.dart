import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/firestore_provider.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final shopFirestoreProvider = Provider<ShopFirestore>(
    (ref) => ShopFirestore(firestore: ref.read(firestoreProvider)));

class ShopFirestore {
  ShopFirestore({required FirebaseFirestore firestore})
      : _firestore = firestore;
  final FirebaseFirestore _firestore;
  final shopFirestoreStreamController =
      StreamController<Stream<List<DocumentSnapshot<Map<String, Object?>>>>>();

  Future<Result<QuerySnapshot<Map<String, dynamic>>>> fetchShops(
      {required int limit, String? cursor}) async {
    final ref = _firestore.collection('shops');
    if (cursor == null) {
      final query = ref.orderBy('shop_id', descending: false).limit(limit);

      try {
        final snapshot = await query.get();
        return Success(snapshot);
      } on Exception catch (e) {
        return Error(e);
      }
    } else {
      final query = ref
          .orderBy('shop_id', descending: false)
          .startAfter([cursor]).limit(limit);

      try {
        final snapshot = await query.get();
        return Success(snapshot);
      } on Exception catch (e) {
        return Error(e);
      }
    }
  }

  Future<Result<void>> postShop(
      {required Map<String, dynamic> shopData}) async {
    final ref = _firestore.collection('shops').doc(shopData['shop_id']);
    final geo = Geoflutterfire();
    final position = geo.point(
        latitude: shopData['latitude'], longitude: shopData['longitude']);

    try {
      final geoShopData = {
        'name': shopData['name'],
        'shop_id': shopData['shop_id'],
        'position': position.data,
        'comment': shopData['comment'],
        'images': shopData['images'],
        'service_tags': shopData['service_tags'],
        'area_tags': shopData['area_tags'],
        'food_tags': shopData['food_tags'],
        'post_user': shopData['post_user'],
        'price': shopData['price'],
      };
      await ref.set(geoShopData);
      return Success(null);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<QuerySnapshot<Map<String, dynamic>>?>> fetchShopByShopId(
      {required String shopId}) async {
    try {
      final shopData = await _firestore
          .collection('shops')
          .where('shop_id', isEqualTo: shopId)
          .get();

      return Success(shopData);
    } on Exception catch (e) {
      return Error(e);
    }
  }

  Future<Result<String>> fetchShopInMapStream(
      {required double latitude,
      required double longitude,
      required radius}) async {
    try {
      final _geo = Geoflutterfire();
      final reference = _firestore.collection('shops');
      final center = GeoFirePoint(latitude, longitude);
      final stream = _geo
          .collection(collectionRef: reference)
          .within(center: center, radius: radius, field: 'position');

      shopFirestoreStreamController.add(stream);

      return Success('SUCCESS');
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
