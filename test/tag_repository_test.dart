import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/tag_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/tag_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/tag_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/repository/tag_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tag_repository_test.mocks.dart';

@GenerateMocks([TagDataSource])
void main() {
  final _tagDataSource = MockTagDataSource();

  final container = ProviderContainer(overrides: [
    tagRepositoryProvider.overrideWithProvider(Provider<TagRepository>(
        (ref) => TagRepositoryImpl(dataSource: _tagDataSource))),
  ]);

  group('fetch all tags', () {
    test('when there are tags to return', () async {
      when(_tagDataSource.fetchAllTags()).thenAnswer((_) async {
        return Success([
          TagModel(id: 1, name: 'tag1'),
          TagModel(id: 2, name: 'tag2'),
        ]);
      });

      final model = container.read(tagRepositoryProvider);
      final result = await model.fetchAllTags();

      result.whenWithResult(
        (tags) {
          expect(tags.value.first.name, 'tag1');
          expect(tags.value.length, 2);
        },
        (e) => expect(e, Exception('Unhendled part, could be anything')),
      );
    });
  });
}
