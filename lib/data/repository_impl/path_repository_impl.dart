import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/path_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/path_repository.dart';

class PathRepositoryImpl implements PathRepository {
  PathRepositoryImpl({required PathDataSource dataSource})
      : _dataSource = dataSource;

  final PathDataSource _dataSource;

  @override
  Future<Result<Directory>> getTempDirectory() async {
    final pathResult = await _dataSource.getTempDirectory();

    return pathResult.whenWithResult(
      (path) => Success(path.value),
      (e) => Error(Exception(e)),
    );
  }
}
