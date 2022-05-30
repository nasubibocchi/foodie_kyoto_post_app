import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/constants/post_users_data.dart';
import 'package:foodie_kyoto_post_app/constants/tags_data.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/components/tag_button.dart';
import 'package:foodie_kyoto_post_app/ui/components/user_button.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostShopPage extends HookConsumerWidget {
  const PostShopPage({Key? key, required this.shopId}) : super(key: key);

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postShopProvider(shopId));

    return Scaffold(
      appBar: AppBar(),
      body: state.when((shop,
          commentController,
          comment,
          images,
          selectedServiceTags,
          selectedAreaTags,
          selectedFoodTags,
          postUserName) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(shop?.name ?? ''),
              const SizedBox(height: 20),
              images.isNotEmpty
                  ? SizedBox(
                      height: 350,
                      child: PageView.builder(
                          itemCount: images.length,
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                                onTap: () async {
                                  try {
                                    ref
                                        .read(postShopProvider(shopId).notifier)
                                        .changeImage(index);
                                  } catch (e) {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const OkDialog(
                                              title: 'エラー',
                                              body:
                                                  '画像選択に失敗しました。もう一度試してみてください。');
                                        });
                                  }
                                },
                                child: Image.file(File(images[index].path)));
                          }),
                    )
                  : GestureDetector(
                      onTap: () async {
                        try {
                          ref
                              .read(postShopProvider(shopId).notifier)
                              .selectImages();
                        } catch (e) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return const OkDialog(
                                    title: 'エラー',
                                    body: '画像選択に失敗しました。もう一度試してみてください。');
                              });
                        }
                      },
                      child: Container(
                        height: 350,
                        width: 350,
                        decoration:
                            const BoxDecoration(color: AppColors.appBeige),
                        child: const Center(
                          child: Text(
                            'タップして画像を追加',
                            style: TextStyle(color: AppColors.appBlack),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              TextField(
                controller: commentController,
                onChanged:
                    ref.read(postShopProvider(shopId).notifier).editComment,
              ),
              const SizedBox(height: 4),
              _ServiceTagsWidget(shopId: shopId),
              const SizedBox(height: 4),
              _AreaTagsWidget(shopId: shopId),
              const SizedBox(height: 4),
              _FoodTagsWidget(shopId: shopId),
              const SizedBox(height: 4),
              _SelectedTagsWidget(shopId: shopId),
              const SizedBox(height: 4),
              _PostUsersWidget(shopId: shopId),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    ref
                        .read(postShopProvider(shopId).notifier)
                        .postShop()
                        .then((postResults) async {
                      if (postResults == PostResults.success) {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return const OkDialog(
                                  title: 'SUCCESS!', body: '登録に成功しました。');
                            });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.appPink,
                    shape: const StadiumBorder(),
                    elevation: 2,
                  ),
                  child: const Text(
                    '登録',
                    style: TextStyle(color: AppColors.appBlack, fontSize: 16),
                  )),
              const SizedBox(height: 24),
            ],
          ),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.appGrey),
        );
      }, error: () {
        return const Center(
          child: Text('error'),
        );
      }),
    );
  }
}

class _ServiceTagsWidget extends ConsumerWidget {
  const _ServiceTagsWidget({required this.shopId});

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postShopProvider(shopId));

    return state.when(
      (shop, commentController, comment, images, selectedServiceTags,
          selectedAreaTags, selectedFoodTags, postUserName) {
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
                    'サービス',
                    style: TextStyle(color: AppColors.appBlack, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 16,
                    children: ServiceTags.serviceTags.entries
                        .map((e) => TagButton(
                            onTap: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
                                  .addServiceTag(e.key);
                            },
                            onTapCloseIcon: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
                                  .removeServiceTag(e.key);
                            },
                            tagName: e.value,
                            isSelected: selectedServiceTags.contains(e.key)))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
      error: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
    );
  }
}

class _AreaTagsWidget extends ConsumerWidget {
  const _AreaTagsWidget({required this.shopId});

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postShopProvider(shopId));

    return state.when(
      (shop, commentController, comment, images, selectedServiceTags,
          selectedAreaTags, selectedFoodTags, postUserName) {
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
                    'エリア',
                    style: TextStyle(color: AppColors.appBlack, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 16,
                    children: AreaTags.areaTags.entries
                        .map((e) => TagButton(
                            onTap: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
                                  .addAreaTag(e.key);
                            },
                            onTapCloseIcon: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
                                  .removeAreaTag(e.key);
                            },
                            tagName: e.value,
                            isSelected: selectedAreaTags.contains(e.key)))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
      error: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
    );
  }
}

class _FoodTagsWidget extends ConsumerWidget {
  const _FoodTagsWidget({required this.shopId});

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postShopProvider(shopId));

    return state.when(
      (shop, commentController, comment, images, selectedServiceTags,
          selectedAreaTags, selectedFoodTags, postUserName) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 16,
                    children: FoodTags.foodTags.entries
                        .map((e) => TagButton(
                            onTap: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
                                  .addFoodTag(e.key);
                            },
                            onTapCloseIcon: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
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
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
      error: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
    );
  }
}

class _SelectedTagsWidget extends ConsumerWidget {
  const _SelectedTagsWidget({Key? key, required this.shopId}) : super(key: key);

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postShopProvider(shopId));

    return state.when(
      (shop, commentController, comment, images, selectedServiceTags,
          selectedAreaTags, selectedFoodTags, postUserName) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '選択済みタグ',
                  style: TextStyle(color: AppColors.appBlack, fontSize: 16),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ServiceTags.serviceTags.entries
                          .map((e) => selectedServiceTags.contains(e.key)
                              ? TagButton(
                                  onTap: () {
                                    ref
                                        .read(postShopProvider(shopId).notifier)
                                        .addServiceTag(e.key);
                                  },
                                  onTapCloseIcon: () {
                                    ref
                                        .read(postShopProvider(shopId).notifier)
                                        .removeServiceTag(e.key);
                                  },
                                  tagName: e.value,
                                  isSelected:
                                      selectedServiceTags.contains(e.key))
                              : const SizedBox())
                          .toList() +
                      AreaTags.areaTags.entries
                          .map((e) => selectedAreaTags.contains(e.key)
                              ? TagButton(
                                  onTap: () {
                                    ref
                                        .read(postShopProvider(shopId).notifier)
                                        .addAreaTag(e.key);
                                  },
                                  onTapCloseIcon: () {
                                    ref
                                        .read(postShopProvider(shopId).notifier)
                                        .removeAreaTag(e.key);
                                  },
                                  tagName: e.value,
                                  isSelected: selectedAreaTags.contains(e.key))
                              : const SizedBox())
                          .toList() +
                      FoodTags.foodTags.entries
                          .map((e) => selectedFoodTags.contains(e.key)
                              ? TagButton(
                                  onTap: () {
                                    ref
                                        .read(postShopProvider(shopId).notifier)
                                        .addFoodTag(e.key);
                                  },
                                  onTapCloseIcon: () {
                                    ref
                                        .read(postShopProvider(shopId).notifier)
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
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
      error: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
    );
  }
}

class _PostUsersWidget extends ConsumerWidget {
  const _PostUsersWidget({required this.shopId});

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postShopProvider(shopId));
    return state.when(
      (shop, commentController, comment, images, selectedServiceTags,
          selectedAreaTags, selectedFoodTags, postUserName) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 16,
                    children: PostUsers.postUsers.entries
                        .map((e) => UserButton(
                            onTap: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
                                  .selectPostUser(e.key);
                            },
                            onTapCloseIcon: () {
                              ref
                                  .read(postShopProvider(shopId).notifier)
                                  .removeSelectedUser();
                            },
                            userName: e.value,
                            isSelected: postUserName.contains(e.value)))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
      error: () => const Center(
        child: CircularProgressIndicator(color: AppColors.appGrey),
      ),
    );
  }
}
