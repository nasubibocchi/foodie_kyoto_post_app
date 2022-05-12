import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/tag_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/tag_firestore.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/model_data_source_impl/tag_data_source_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tagDataSourceProvider = Provider<TagDataSource>(
    (ref) => TagDataSourceImpl(tagFirestore: ref.read(tagFirestoreProvider)));

abstract class TagDataSource {
  Future<Result<List<TagModel>>> fetchAllTags();
}
