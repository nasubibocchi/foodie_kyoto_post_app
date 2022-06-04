import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageWidget extends ConsumerWidget {
  const ImageWidget({Key? key, required this.shopId}) : super(key: key);

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController(viewportFraction: 0.9);
    final state = ref.watch(postShopProvider(shopId));

    return state.when(
      (_, __, ___, images, ____, _____, ______, _______, ________, _________) {
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
                                        return _ChangeOrDeleteDialog(
                                            onTapChange: () async {
                                          try {
                                            ref
                                                .read(postShopProvider(shopId)
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
                                              .read(postShopProvider(shopId)
                                                  .notifier)
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
                    ref.read(postShopProvider(shopId).notifier).selectImages();
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
      },
      loading: () => const SizedBox(),
      error: () => const SizedBox(),
    );
  }
}

class _ChangeOrDeleteDialog extends StatelessWidget {
  const _ChangeOrDeleteDialog(
      {Key? key, required this.onTapChange, required this.onTapDelete})
      : super(key: key);

  final VoidCallback onTapChange;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: AppColors.appGrey)),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                TextButton(
                    onPressed: onTapChange,
                    child: const Text(
                      '変更',
                      style: TextStyle(color: AppColors.appBlack, fontSize: 16),
                    )),
              ],
            ),
            const Divider(color: AppColors.appBeige, thickness: 1),
            TextButton(
                onPressed: onTapDelete,
                child: const Text(
                  '削除',
                  style: TextStyle(color: AppColors.appBlack, fontSize: 16),
                )),
          ],
        ),
      ],
    );
  }
}
