import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/image_file_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_image_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_movie_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/menu_use_case.dart';
import 'package:foodie_kyoto_post_app/domain/use_case/path_use_case.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

final postMenuProvider = StateNotifierProvider.family<
        PostMenuController, PostMenuState, Tuple2<String, Menu?>>(
    (ref, tuple) => PostMenuController(
          ref.read(menuUseCaseProvider),
          ref.read(menuImageUseCaseProvider),
          ref.read(imageFileUseCaseProvider),
          ref.read(pathUseCaseProvider),
          ref.read(menuMovieUseCaseProvider),
          tuple.item1,
          tuple.item2,
        ));
