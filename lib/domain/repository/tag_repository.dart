import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/tag_data_source.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/tag_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/entity/tag.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tagRepositoryProvider = Provider<TagRepository>(
    (ref) => TagRepositoryImpl(dataSource: ref.read(tagDataSourceProvider)));

abstract class TagRepository {
  Future<Result<List<Tag>>> fetchAllTags();
}
