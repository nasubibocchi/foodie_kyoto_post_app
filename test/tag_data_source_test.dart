import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/tag_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/tag_firestore.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/tag_data_source_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tag_data_source_test.mocks.dart';

@GenerateMocks([TagFirestore])
void main() {
  final _tagFirestore = MockTagFirestore();
  final _firestore = FakeFirebaseFirestore();

  final container = ProviderContainer(overrides: [
    tagFirestoreProvider.overrideWithProvider(
        Provider<TagFirestore>((ref) => TagFirestore(firestore: _firestore))),
    tagDataSourceProvider.overrideWithProvider(Provider<TagDataSource>((ref) =>
        TagDataSourceImpl(tagFirestore: ref.read(tagFirestoreProvider)))),
  ]);

  setUpAll(() async {
    await _firestore.collection('tags').add(
      <String, dynamic>{
        'id': 1,
        'name': 'tag1',
        'shop_id_list': ['shop1', 'shop2'],
      },
    );

    await _firestore.collection('tags').add(
      <String, dynamic>{
        'id': 2,
        'name': 'tag2',
        'shop_id_list': [],
      },
    );
  });

  group('fetchAllTags', () {
    test('when there are tags to return', () async {
      when(_tagFirestore.fetchAllTags()).thenAnswer((_) async {
        try {
          final firestoreResult =
              await _firestore.collection('tags').orderBy('name').get();
          return Success(firestoreResult);
        } on Exception catch (e) {
          return Error(e);
        }
      });

      final model = container.read(tagDataSourceProvider);
      final result = await model.fetchAllTags();

      result.whenWithResult(
        (tags) => expect(tags.value.first.name, 'tag1'),
        (e) => expect(e, Exception('Unhendled part, could be anything')),
      );
    });
  });
}
