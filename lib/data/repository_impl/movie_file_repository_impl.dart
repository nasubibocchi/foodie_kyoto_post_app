import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/movie_file_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/domain/repository/movie_file_repository.dart';

class MovieFileRepositoryImpl implements MovieFileRepository {
  MovieFileRepositoryImpl({required MovieFileDataSource dataSource})
      : _dataSource = dataSource;

  final MovieFileDataSource _dataSource;

  @override
  Future<Result<File?>> pickVideo() async {
    final dataSourceResult = await _dataSource.pickVideo();
    return dataSourceResult.whenWithResult(
      (file) => Success(file.value),
      (e) => Error(Exception(e)),
    );
  }
}
