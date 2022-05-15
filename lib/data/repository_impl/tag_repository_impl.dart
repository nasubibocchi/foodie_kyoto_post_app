import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/tag_data_source.dart';
import 'package:foodie_kyoto_post_app/domain/entity/tag.dart';
import 'package:foodie_kyoto_post_app/domain/repository/tag_repository.dart';

class TagRepositoryImpl implements TagRepository {
  TagRepositoryImpl({required TagDataSource dataSource})
      : _dataSource = dataSource;

  final TagDataSource _dataSource;

  @override
  Future<Result<List<Tag>>> fetchAllTags() async {
    final dataSourceResult = await _dataSource.fetchAllTags();

    return dataSourceResult.whenWithResult(
      (data) =>
          Success(data.value.map((e) => Tag(id: e.id, name: e.name)).toList()),
      (e) => Error(Exception(e)),
    );
  }
}
