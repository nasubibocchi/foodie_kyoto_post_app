import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/data/local/data_source/image_file_data_source.dart';
import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/repository_impl/image_file_repository_impl.dart';
import 'package:foodie_kyoto_post_app/domain/repository/image_file_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'image_file_repository_test.mocks.dart';

@GenerateMocks([ImageFileDataSource])
void main() {
  final _dataSource = MockImageFileDataSource();

  final container = ProviderContainer(overrides: [
    imageFileRepositoryProvider.overrideWithProvider(
        Provider<ImageFileRepositoryImpl>(
            (ref) => ImageFileRepositoryImpl(dataSource: _dataSource))),
  ]);

  group('pickMultiImage', () {
    test('when there is file list to return', () async {
      when(_dataSource.pickMultiImage()).thenAnswer((_) async {
        return Success([
          File('path1'),
          File('path2'),
        ]);
      });

      final model = container.read(imageFileRepositoryProvider);
      final result = await model.pickMultiImage();

      result.whenWithResult(
        (fileList) {
          expect(fileList.value.first.path, 'path1');
        },
        (e) => expect(e, Error(Exception('Unhendled part, could be anything'))),
      );
    });

    test('when there is no file to return', () async {
      when(_dataSource.pickMultiImage()).thenAnswer((_) async {
        return Success(<File>[]);
      });

      final model = container.read(imageFileRepositoryProvider);
      final result = await model.pickMultiImage();

      result.whenWithResult(
        (fileList) {
          expect(fileList.value.length, 0);
        },
        (e) => expect(e, Error(Exception('Unhendled part, could be anything'))),
      );
    });
  });

  group('pickImage', () {
    test('when there is a file to return', () async {
      when(_dataSource.pickImage()).thenAnswer((_) async {
        return Success(File('path'));
      });

      final model = container.read(imageFileRepositoryProvider);
      final result = await model.pickImage();

      result.whenWithResult(
        (file) {
          expect(file.value?.path, 'path');
        },
        (e) => expect(e, Error(Exception('Unhendled part, could be anything'))),
      );
    });

    test('when result is null', () async {
      when(_dataSource.pickImage()).thenAnswer((_) async {
        return Success(null);
      });

      final model = container.read(imageFileRepositoryProvider);
      final result = await model.pickImage();

      result.whenWithResult(
        (file) {
          expect(file.value?.path, null);
        },
        (e) => expect(e, Error(Exception('Unhendled part, could be anything'))),
      );
    });
  });
}
