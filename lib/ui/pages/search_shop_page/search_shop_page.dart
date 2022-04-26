import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchShopPage extends HookConsumerWidget {
  const SearchShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchShopProvider);
    final shopList =
        ref.watch(searchShopProvider.select((s) => s.searchResultList));

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: state.searchController,
              onChanged: (body) async {
                ref.read(searchShopProvider.notifier).onEditSearchText(body);
                ref.read(searchShopProvider.notifier).searchShops();
              },
            ),
            const SizedBox(height: 20),
            shopList != null && shopList.isNotEmpty
                ? ListView.builder(
                    itemCount: shopList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return TextButton(
                          onPressed: () {}, child: Text(shopList[index]));
                    })
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
