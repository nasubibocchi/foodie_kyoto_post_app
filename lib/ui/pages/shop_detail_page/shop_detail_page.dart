import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/constants/tags_data.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';
import 'package:foodie_kyoto_post_app/ui/pages/shop_detail_page/shop_detail_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopDetailPage extends HookConsumerWidget {
  const ShopDetailPage({Key? key, required this.shop}) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shopDetailProvider(shop.shopId));
    final _shopImageController =
        PageController(initialPage: 0, viewportFraction: 0.9);

    final serviceTags =
        shop.serviceTags.map((key) => ServiceTags.serviceTags[key]).toList();
    final areaTags =
        shop.areaTags.map((key) => AreaTags.areaTags[key]).toList();
    final foodTags =
        shop.foodTags.map((key) => FoodTags.foodTags[key]).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.appBlack),
        title: Text(
          shop.name,
          style: const TextStyle(color: AppColors.appBlack),
        ),
      ),
      body: state.when(
        (menu) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  const Divider(
                    thickness: 4,
                    color: AppColors.appDarkBeige,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 350,
                        child: PageView.builder(
                            itemCount: shop.images.length,
                            scrollDirection: Axis.horizontal,
                            controller: _shopImageController,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                    imageUrl: shop.images[index]),
                              );
                            }),
                      ),
                      const SizedBox(height: 8),
                      SmoothPageIndicator(
                        controller: _shopImageController,
                        count: shop.images.length,
                        effect: const SlideEffect(
                          spacing: 8.0,
                          radius: 12.0,
                          dotWidth: 12.0,
                          dotHeight: 12.0,
                          paintStyle: PaintingStyle.fill,
                          strokeWidth: 1.5,
                          dotColor: AppColors.appDarkBeige,
                          activeDotColor: AppColors.appOrange,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  const Divider(
                    thickness: 4,
                    color: AppColors.appDarkBeige,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'レビュー（${shop.postUser}）',
                          style: const TextStyle(
                              color: AppColors.appBlack, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            shop.comment,
                            maxLines: 10,
                            style: const TextStyle(
                                color: AppColors.appBlack, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 8),
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '予算',
                          style: TextStyle(
                              color: AppColors.appBlack, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '¥${shop.price}',
                              style: const TextStyle(
                                  color: AppColors.appBlack, fontSize: 14),
                            ),
                            const SizedBox(width: 2),
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
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '選択したタグ',
                          style: TextStyle(
                              color: AppColors.appBlack, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                            children: (serviceTags + areaTags + foodTags)
                                .map((e) => _TagWidget(tagName: e))
                                .toList()),
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
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            const Text(
                              'menu',
                              style: TextStyle(
                                  color: AppColors.appBlack, fontSize: 16),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  context.go(
                                    '/${RouteNames.shopDetailPage}/${RouteNames.postMenuPage}',
                                    extra: shop.shopId,
                                  );
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.appGrey,
                                  size: 24,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        menu.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: menu.length,
                                itemBuilder: (context, int index) {
                                  return _MenuWidget(menu: menu[index]);
                                })
                            : const Text(
                                'メニューを追加しましょう',
                                style: TextStyle(color: AppColors.appBlack),
                              ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
            ],
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.appGrey),
          );
        },
        error: () {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.appGrey),
          );
        },
      ),
    );
  }
}

class _TagWidget extends StatelessWidget {
  const _TagWidget({Key? key, required this.tagName}) : super(key: key);

  final String? tagName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.appInactiveButtonBeige,
          borderRadius: BorderRadius.circular(8),
          boxShadow: (const [
            BoxShadow(offset: Offset(0, 2), color: Colors.grey, blurRadius: 2)
          ])),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: tagName != null
          ? Text(
              tagName!,
              style: const TextStyle(color: AppColors.appBlack, fontSize: 14),
            )
          : const SizedBox(),
    );
  }
}

class _MenuWidget extends StatelessWidget {
  const _MenuWidget({Key? key, required this.menu}) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Container(
          height: 96,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.appInactiveButtonBeige,
            boxShadow: [BoxShadow()],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 96,
                width: 96,
                child: CachedNetworkImage(imageUrl: menu.images.first),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              menu.name,
                              style: const TextStyle(
                                  color: AppColors.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '¥${menu.price}',
                              style: const TextStyle(
                                  color: AppColors.appBlack, fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          menu.postUser,
                          style: const TextStyle(
                              color: AppColors.appBlack, fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 0),
                          child: Text(
                            menu.review,
                            maxLines: 3,
                            style: const TextStyle(
                                color: AppColors.appBlack, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          // メニュー編集ページへ移動
                        },
                        child: const Icon(
                          Icons.edit_rounded,
                          color: AppColors.appGrey,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
