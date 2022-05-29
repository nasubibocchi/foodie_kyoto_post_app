import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/path_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/path_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pathRepositoryProvider = Provider<PathRepositoryImpl>(
    (ref) => PathRepositoryImpl(dataSource: ref.read(pathDataSourceProvider)));

abstract class PathRepository {
  Future<Result<Directory>> getTempDirectory();
}
