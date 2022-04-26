import 'package:foodie_kyoto_post_app/domain/use_case/places_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchShopProvider =
    StateNotifierProvider<SearchShopController, SearchShopState>(
        (ref) => SearchShopController(ref.read(placesUseCaseProvider)));
