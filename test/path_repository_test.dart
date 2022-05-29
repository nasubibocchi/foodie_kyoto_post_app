import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/local/data_source/path_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/path_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/repository/path_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'path_repository_test.mocks.dart';

@GenerateMocks([PathDataSource])
void main() {
  final _pathDataSource = MockPathDataSource();
  final container = ProviderContainer(overrides: [
    pathRepositoryProvider.overrideWithProvider(Provider<PathRepositoryImpl>(
        (ref) => PathRepositoryImpl(dataSource: _pathDataSource))),
  ]);

  group('getTempDirectory', () {
    test('success getting temporary directory', () async {
      when(_pathDataSource.getTempDirectory()).thenAnswer((_) async {
        return Success(Directory('path'));
      });

      final model = container.read(pathRepositoryProvider);
      final result = await model.getTempDirectory();

      result.whenWithResult(
        (directory) => expect(directory.value.path, 'path'),
        (e) => expect(e, Exception('Unhendled part, could be anything')),
      );
    });
  });
}
