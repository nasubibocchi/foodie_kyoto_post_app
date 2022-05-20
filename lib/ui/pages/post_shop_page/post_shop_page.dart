import 'dart:io';

import 'package:flutter/material.dart';
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
              images != null
                  ? SizedBox(
                      height: 130,
                      child: PageView.builder(
                          itemCount: images.length,
                          itemBuilder: (context, int index) {
                            return Image.file(File(images[index].path));
                          }),
                    )
                  : const SizedBox(),
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
