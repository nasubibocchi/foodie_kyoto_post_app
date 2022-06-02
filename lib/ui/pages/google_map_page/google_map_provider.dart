import 'package:foodie_kyoto_post_app/domain/use_case/shop_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final googleMapProvider =
    StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
        (ref) => GoogleMapPageController(ref.read(shopUseCaseProvider)));
