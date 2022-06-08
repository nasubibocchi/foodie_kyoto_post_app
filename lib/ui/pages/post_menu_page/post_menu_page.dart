import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/menu_image_widget.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/menu_movie_widget.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

class PostMenuPage extends HookConsumerWidget {
  const PostMenuPage({Key? key, required this.shopId, this.menu})
      : super(key: key);

  final String shopId;
  final Menu? menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postMenuProvider(Tuple2(shopId, menu)));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.appBlack),
        title: const Text(
          'メニューを追加',
          style: TextStyle(color: AppColors.appBlack),
        ),
      ),
      body: state.when(
        (
          _,
          nameController,
          __,
          movies,
          ____,
          priceController,
          _____,
          reviewController,
          ______,
          enReviewController,
          foodTags,
          postUser,
          isPosting,
        ) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  thickness: 4,
                  color: AppColors.appDarkBeige,
                  indent: 0,
                  endIndent: 0,
                ),
                MenuImageWidget(shopId: shopId),
                const Divider(
                  thickness: 4,
                  color: AppColors.appDarkBeige,
                  indent: 0,
                  endIndent: 0,
                ),
                MenuMovieWidget(
                  shopId: shopId,
                  movies: movies,
                  onTapDeleteMovie: () => ref
                      .read(postMenuProvider(Tuple2(shopId, menu)).notifier)
                      .deleteSelectedMovie()
                      .then((_) => Navigator.of(context).pop()),
                  onTapAddMovie: () async {
                    try {
                      await ref
                          .read(postMenuProvider(Tuple2(shopId, menu)).notifier)
                          .selectMovie();
                    } catch (e) {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return const OkDialog(
                                title: 'エラー',
                                body: '動画選択に失敗しました。もう一度試してみてください。');
                          });
                    }
                  },
                ),
                const Divider(
                  thickness: 4,
                  color: AppColors.appDarkBeige,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'メニュー名',
                        style:
                            TextStyle(color: AppColors.appBlack, fontSize: 16),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: '（必須）メニュー名を入力',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onChanged: ref
                            .read(
                                postMenuProvider(Tuple2(shopId, menu)).notifier)
                            .onEditMenuName,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 4,
                  color: AppColors.appDarkBeige,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'レビューコメント(日本語)',
                        style:
                            TextStyle(color: AppColors.appBlack, fontSize: 16),
                      ),
                      TextField(
                        controller: reviewController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: '（必須）日本語でレビューを入力',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onChanged: ref
                            .read(
                                postMenuProvider(Tuple2(shopId, menu)).notifier)
                            .onEditReview,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 4,
                  color: AppColors.appDarkBeige,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'レビューコメント(英語)',
                        style:
                            TextStyle(color: AppColors.appBlack, fontSize: 16),
                      ),
                      TextField(
                        controller: enReviewController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: '英語でレビューを入力',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onChanged: ref
                            .read(
                                postMenuProvider(Tuple2(shopId, menu)).notifier)
                            .onEditEnglishReview,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 4,
                  color: AppColors.appDarkBeige,
                  indent: 0,
                  endIndent: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '料金',
                        style:
                            TextStyle(color: AppColors.appBlack, fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: priceController,
                              textAlign: TextAlign.end,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                hintText: '￥予算を入力',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onChanged: ref
                                  .read(postMenuProvider(Tuple2(shopId, menu))
                                      .notifier)
                                  .onEditPrice,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '円',
                            style: TextStyle(
                                color: AppColors.appBlack, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 4,
                  color: AppColors.appDarkBeige,
                  indent: 0,
                  endIndent: 0,
                ),
              ],
            ),
          );
        },
        error: () {
          return const Center(
            child: Text('error'),
          );
        },
      ),
    );
  }
}
