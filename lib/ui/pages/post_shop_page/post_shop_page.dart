import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/constants/post_users_data.dart';
import 'package:foodie_kyoto_post_app/constants/tags_data.dart';
import 'package:foodie_kyoto_post_app/ui/components/tag_button.dart';
import 'package:foodie_kyoto_post_app/ui/components/user_button.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/image_widget.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_button.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostShopPage extends HookConsumerWidget {
  PostShopPage({Key? key, required this.shopId}) : super(key: key);

  final String shopId;
  final GlobalKey scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postShopProvider(shopId));
    final shop = ref.watch(postShopProvider(shopId).select((s) => s.when(
        (shop, _, __, ___, ____, _____, ______, _______, ________, _________,
                __________) =>
            shop,
        loading: () => null,
        error: () => null)));

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.appBlack),
        title: Text(
          shop?.name ?? '',
          style: const TextStyle(color: AppColors.appBlack),
        ),
      ),
      body: state.when((shop, commentController, _, images, __, priceController,
          ___, ____, _____, ______, isPosting) {
        const _divider = Divider(
          thickness: 4,
          color: AppColors.appDarkBeige,
          indent: 0,
          endIndent: 0,
        );

        return isPosting
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.appGrey))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _divider,
                    const SizedBox(height: 8),
                    ImageWidget(shopId: shopId),
                    const SizedBox(height: 20),
                    _divider,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'レビューコメント',
                            style: TextStyle(
                                color: AppColors.appBlack, fontSize: 16),
                          ),
                          TextField(
                            controller: commentController,
                            maxLines: 8,
                            cursorColor: AppColors.appOrange,
                            decoration: const InputDecoration(
                              hintText: '（例）雰囲気がいい',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onChanged: ref
                                .read(postShopProvider(shopId).notifier)
                                .editComment,
                          ),
                        ],
                      ),
                    ),
                    _divider,
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '予算',
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
                                      .read(postShopProvider(shopId).notifier)
                                      .editPrice,
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
                    _divider,
                    _ServiceTagsWidget(shopId: shopId),
                    _divider,
                    _AreaTagsWidget(shopId: shopId),
                    _divider,
                    _FoodTagsWidget(shopId: shopId),
                    _divider,
                    _SelectedTagsWidget(shopId: shopId),
                    _divider,
                    _PostUsersWidget(shopId: shopId),
                    _divider,
                    const SizedBox(height: 24),
                    PostButton(scaffoldKey, shopId: shopId),
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
      (_, __, ___, ____, _____, ______, selectedServiceTags, _______, ________,
          _________, __________) {
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
      (_, __, ___, ____, _____, ______, _______, selectedAreaTags, ________,
          _________, __________) {
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
      (_, __, ___, ____, _____, ______, _______, ________, selectedFoodTags,
          _________, __________) {
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
      (_, __, ___, ____, _____, ______, selectedServiceTags, selectedAreaTags,
          selectedFoodTags, _______, ________) {
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
      (_, __, ___, ____, _____, ______, _______, ________, _________,
          postUserName, __________) {
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
