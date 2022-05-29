import 'dart:io';

import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final pathProviderDataSourceProvider =
    Provider<PathProviderDataSource>((ref) => PathProviderDataSource());

class PathProviderDataSource {
  Future<Result<Directory>> getTempDirectory() async {
    try {
      final pathProviderResult = await getTemporaryDirectory();
      return Success(pathProviderResult);
    } on Exception catch (e) {
      return Error(e);
    }
  }
}
