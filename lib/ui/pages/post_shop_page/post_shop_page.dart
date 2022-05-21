import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
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
      body: state.when((shop, commentController, comment, images) {
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
            ],
          ),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }, error: () {
        return const Center(
          child: Text('error'),
        );
      }),
    );
  }
}
