import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostMenuPage extends HookConsumerWidget {
  const PostMenuPage({Key? key, required this.shopId}) : super(key: key);

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController =
        ref.watch(postMenuProvider(shopId).select((s) => s.nameController));

    final priceController =
        ref.watch(postMenuProvider(shopId).select((s) => s.priceController));

    final reviewController =
        ref.watch(postMenuProvider(shopId).select((s) => s.reviewController));

    final enReviewController =
        ref.watch(postMenuProvider(shopId).select((s) => s.enReviewController));

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              thickness: 4,
              color: AppColors.appDarkBeige,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'メニュー名',
                    style: TextStyle(color: AppColors.appBlack, fontSize: 16),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: '（必須）メニュー名を入力',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    onChanged: ref
                        .read(postMenuProvider(shopId).notifier)
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'レビューコメント(日本語)',
                    style: TextStyle(color: AppColors.appBlack, fontSize: 16),
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
                        .read(postMenuProvider(shopId).notifier)
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'レビューコメント(英語)',
                    style: TextStyle(color: AppColors.appBlack, fontSize: 16),
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
                        .read(postMenuProvider(shopId).notifier)
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '料金',
                    style: TextStyle(color: AppColors.appBlack, fontSize: 16),
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
                          keyboardType: const TextInputType.numberWithOptions(
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
                              .read(postMenuProvider(shopId).notifier)
                              .onEditPrice,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '円',
                        style:
                            TextStyle(color: AppColors.appBlack, fontSize: 12),
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
      ),
    );
  }
}
