import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source_impl/path_data_source_impl.dart';
import 'package:foodie_kyoto_post_app/data/local/data_source_impl/path_provider_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pathDataSourceProvider = Provider<PathDataSourceImpl>((ref) =>
    PathDataSourceImpl(pathProvider: ref.read(pathProviderDataSourceProvider)));

abstract class PathDataSource {
  Future<Result<Directory>> getTempDirectory();
}
