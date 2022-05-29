import 'dart:io';

import 'package:foodie_kyoto_post_app/data/local/data_source/path_data_source.dart';
import 'package:foodie_kyoto_post_app/data/local/data_source_impl/path_provider_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';

class PathDataSourceImpl implements PathDataSource {
  PathDataSourceImpl({required PathProviderDataSource pathProvider})
      : _pathProvider = pathProvider;

  final PathProviderDataSource _pathProvider;

  @override
  Future<Result<Directory>> getTempDirectory() async {
    final pathProviderResult = await _pathProvider.getTempDirectory();

    return pathProviderResult.whenWithResult(
      (path) => Success(path.value),
      (e) => Error(Exception(e)),
    );
  }
}
