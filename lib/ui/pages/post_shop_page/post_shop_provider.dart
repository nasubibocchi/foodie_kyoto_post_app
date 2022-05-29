import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postShopProvider = StateNotifierProvider.family
    .autoDispose<PostShopController, PostShopState, String>((ref, _shopId) =>
        PostShopController(
            ref.read(shopUseCaseProvider),
            ref.read(placesUseCaseProvider),
            ref.read(shopImageUseCaseProvider),
            ref.read(imageFileUseCaseProvider),
            _shopId));
