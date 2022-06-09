import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/constants/post_users_data.dart';
import 'package:foodie_kyoto_post_app/constants/tags_data.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/components/tag_button.dart';
import 'package:foodie_kyoto_post_app/ui/components/user_button.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/menu_image_widget.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/menu_movie_widget.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_button.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

class PostMenuPage extends HookConsumerWidget {
  PostMenuPage({Key? key, required this.shopId, this.menu}) : super(key: key);

  final String shopId;
  final Menu? menu;

  final GlobalKey scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postMenuProvider(Tuple2(shopId, menu)));

    return Scaffold(
      key: scaffoldKey,
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
          images,
          movies,
          __,
          priceController,
          ___,
          reviewController,
          ____,
          enReviewController,
          foodTags,
          postUser,
          isPosting,
        ) {
          return isPosting
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.appGrey),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const Divider(
                        thickness: 4,
                        color: AppColors.appDarkBeige,
                        indent: 0,
                        endIndent: 0,
                      ),
                      MenuImageWidget(
                          shopId: shopId, images: images, menu: menu),
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
                            .read(
                                postMenuProvider(Tuple2(shopId, menu)).notifier)
                            .deleteSelectedMovie()
                            .then((_) => Navigator.of(context).pop()),
                        onTapAddMovie: () async {
                          try {
                            await ref
                                .read(postMenuProvider(Tuple2(shopId, menu))
                                    .notifier)
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'メニュー名',
                              style: TextStyle(
                                  color: AppColors.appBlack, fontSize: 16),
                            ),
                            TextField(
                              controller: nameController,
                              cursorColor: AppColors.appOrange,
                              decoration: const InputDecoration(
                                hintText: '（必須）メニュー名を入力',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onChanged: ref
                                  .read(postMenuProvider(Tuple2(shopId, menu))
                                      .notifier)
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'レビューコメント(日本語)',
                              style: TextStyle(
                                  color: AppColors.appBlack, fontSize: 16),
                            ),
                            TextField(
                              controller: reviewController,
                              cursorColor: AppColors.appOrange,
                              maxLines: 6,
                              decoration: const InputDecoration(
                                hintText: '（必須）日本語でレビューを入力',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onChanged: ref
                                  .read(postMenuProvider(Tuple2(shopId, menu))
                                      .notifier)
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'レビューコメント(英語)',
                              style: TextStyle(
                                  color: AppColors.appBlack, fontSize: 16),
                            ),
                            TextField(
                              controller: enReviewController,
                              cursorColor: AppColors.appOrange,
                              maxLines: 6,
                              decoration: const InputDecoration(
                                hintText: '英語でレビューを入力',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              onChanged: ref
                                  .read(postMenuProvider(Tuple2(shopId, menu))
                                      .notifier)
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '料金',
                              style: TextStyle(
                                  color: AppColors.appBlack, fontSize: 16),
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
                                    cursorColor: AppColors.appOrange,
                                    decoration: const InputDecoration(
                                      hintText: '￥予算を入力',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: ref
                                        .read(postMenuProvider(
                                                Tuple2(shopId, menu))
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
                      _FoodTagsWidget(shopId: shopId, menu: menu),
                      const Divider(
                        thickness: 4,
                        color: AppColors.appDarkBeige,
                        indent: 0,
                        endIndent: 0,
                      ),
                      _SelectedTagsWidget(shopId: shopId, menu: menu),
                      const Divider(
                        thickness: 4,
                        color: AppColors.appDarkBeige,
                        indent: 0,
                        endIndent: 0,
                      ),
                      _PostUsersWidget(shopId: shopId, menu: menu),
                      const Divider(
                        thickness: 4,
                        color: AppColors.appDarkBeige,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const SizedBox(height: 16),
                      PostButton(scaffoldKey, shopId: shopId, menu: menu),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.appGrey,
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

class _FoodTagsWidget extends ConsumerWidget {
  const _FoodTagsWidget({required this.shopId, required this.menu});

  final String shopId;
  final Menu? menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFoodTags =
        ref.watch(postMenuProvider(Tuple2(shopId, menu)).select((s) => s.when(
              (_, __, ___, ____, _____, ______, _______, ________, _________,
                      __________, foodTags, ___________, ____________) =>
                  foodTags,
              loading: () => [],
              error: () => [],
            )));

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'フード',
                style: TextStyle(color: AppColors.appBlack, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 16,
                children: FoodTags.foodTags.entries
                    .map((e) => TagButton(
                        onTap: () {
                          ref
                              .read(postMenuProvider(Tuple2(shopId, menu))
                                  .notifier)
                              .addFoodTag(e.key);
                        },
                        onTapCloseIcon: () {
                          ref
                              .read(postMenuProvider(Tuple2(shopId, menu))
                                  .notifier)
                              .removeFoodTag(e.key);
                        },
                        tagName: e.value,
                        isSelected: selectedFoodTags.contains(e.key)))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedTagsWidget extends ConsumerWidget {
  const _SelectedTagsWidget(
      {Key? key, required this.shopId, required this.menu})
      : super(key: key);

  final String shopId;
  final Menu? menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFoodTags =
        ref.watch(postMenuProvider(Tuple2(shopId, menu)).select((s) => s.when(
              (_, __, ___, ____, _____, ______, _______, ________, _________,
                      __________, foodTags, ___________, ____________) =>
                  foodTags,
              loading: () => [],
              error: () => [],
            )));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              '選択済みタグ',
              style: TextStyle(color: AppColors.appBlack, fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: FoodTags.foodTags.entries
                    .map((e) => selectedFoodTags.contains(e.key)
                        ? TagButton(
                            onTap: () {
                              ref
                                  .read(postMenuProvider(Tuple2(shopId, menu))
                                      .notifier)
                                  .addFoodTag(e.key);
                            },
                            onTapCloseIcon: () {
                              ref
                                  .read(postMenuProvider(Tuple2(shopId, menu))
                                      .notifier)
                                  .removeFoodTag(e.key);
                            },
                            tagName: e.value,
                            isSelected: selectedFoodTags.contains(e.key))
                        : const SizedBox())
                    .toList(),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _PostUsersWidget extends ConsumerWidget {
  const _PostUsersWidget({required this.shopId, required this.menu});

  final String shopId;
  final Menu? menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUser = ref.watch(postMenuProvider(Tuple2(shopId, menu)).select(
        (s) => s.when(
            (_, __, ___, ____, _____, ______, _______, ________, _________,
                    __________, ___________, postUser, ____________) =>
                postUser,
            loading: () => '',
            error: () => '')));

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '登録者',
                style: TextStyle(color: AppColors.appBlack, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 16,
                children: PostUsers.postUsers.entries
                    .map((e) => UserButton(
                        onTap: () {
                          ref
                              .read(postMenuProvider(Tuple2(shopId, menu))
                                  .notifier)
                              .selectPostUser(e.key);
                        },
                        onTapCloseIcon: () {
                          ref
                              .read(postMenuProvider(Tuple2(shopId, menu))
                                  .notifier)
                              .removeSelectedUser();
                        },
                        userName: e.value,
                        isSelected: postUser.contains(e.value)))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
