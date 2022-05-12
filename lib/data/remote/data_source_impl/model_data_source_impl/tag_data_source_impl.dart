import 'package:foodie_kyoto_post_app/data/model/result.dart';
import 'package:foodie_kyoto_post_app/data/model/tag_model.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source/tag_data_source.dart';
import 'package:foodie_kyoto_post_app/data/remote/data_source_impl/firestore_data_source_impl/tag_firestore.dart';

class TagDataSourceImpl implements TagDataSource {
  TagDataSourceImpl({required TagFirestore tagFirestore})
      : _tagFirestore = tagFirestore;

  final TagFirestore _tagFirestore;

  @override
  Future<Result<List<TagModel>>> fetchAllTags() async {
    final firestoreResult = await _tagFirestore.fetchAllTags();

    return firestoreResult.whenWithResult(
      (data) => Success(
          data.value.docs.map((e) => TagModel.fromJson(e.data())).toList()),
      (e) => Error(Exception(e)),
    );
  }
}
