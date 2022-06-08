import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/movie_file_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/movie_file_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final movieFileRepositoryProvider = Provider<MovieFileRepositoryImpl>((ref) =>
    MovieFileRepositoryImpl(dataSource: ref.read(movieFileDataSourceProvider)));

abstract class MovieFileRepository {
  Future<Result<File?>> pickVideo();
}
