import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/components/change_or_delete_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MenuImageWidget extends ConsumerWidget {
  const MenuImageWidget({Key? key, required this.shopId}) : super(key: key);

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(postMenuProvider(shopId).select((s) => s.images));
    final controller = PageController(viewportFraction: 0.9);

    return images.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 350,
                child: PageView.builder(
                    controller: controller,
                    itemCount: images.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ChangeOrDeleteDialog(
                                        onTapChange: () async {
                                      try {
                                        ref
                                            .read(postMenuProvider(shopId)
                                                .notifier)
                                            .changeImage(index);
                                      } catch (e) {
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const OkDialog(
                                                title: 'エラー',
                                                body:
                                                    '画像選択に失敗しました。もう一度試してみてください。',
                                              );
                                            });
                                      }
                                    }, onTapDelete: () {
                                      ref
                                          .read(
                                              postMenuProvider(shopId).notifier)
                                          .deleteSelectedImage(index);
                                    });
                                  });
                            },
                            child: Image.file(File(images[index].path))),
                      );
                    }),
              ),
              const SizedBox(height: 8),
              SmoothPageIndicator(
                controller: controller,
                count: images.length,
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
              const SizedBox(height: 16),
              OutlinedButton.icon(
                  onPressed: () async {
                    try {
                      ref
                          .read(postMenuProvider(shopId).notifier)
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
                  icon: const Icon(Icons.add,
                      color: AppColors.appBlack, size: 16),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.appBlack),
                    shape: const StadiumBorder(),
                  ),
                  label: const Text(
                    '追加',
                    style: TextStyle(color: AppColors.appBlack),
                  )),
            ],
          )
        : GestureDetector(
            onTap: () async {
              try {
                ref.read(postMenuProvider(shopId).notifier).selectImages();
              } catch (e) {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return const OkDialog(
                          title: 'エラー', body: '画像選択に失敗しました。もう一度試してみてください。');
                    });
              }
            },
            child: Container(
              height: 350,
              width: 350,
              decoration: const BoxDecoration(color: AppColors.appBeige),
              child: const Center(
                child: Text(
                  'タップして画像を追加',
                  style: TextStyle(color: AppColors.appBlack),
                ),
              ),
            ),
          );
  }
}
