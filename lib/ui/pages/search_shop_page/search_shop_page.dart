import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/pages/search_shop_page/search_shop_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchShopPage extends HookConsumerWidget {
  const SearchShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchShopProvider);
    final shopList =
        ref.watch(searchShopProvider.select((s) => s.searchResultList));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.appBlack),
        title: const Text(
          '店舗検索',
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
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 2), color: Colors.grey, blurRadius: 2)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    const Icon(Icons.search_rounded, color: Colors.grey),
                    Expanded(
                      child: TextField(
                        cursorColor: AppColors.appOrange,
                        controller: state.searchController,
                        decoration: const InputDecoration(
                          hintText: '店舗名で検索',
                          hintStyle: TextStyle(color: Colors.grey),
                          iconColor: AppColors.appOrange,
                          border: InputBorder.none,
                        ),
                        onChanged: (body) async {
                          ref
                              .read(searchShopProvider.notifier)
                              .onEditSearchText(body);
                          ref.read(searchShopProvider.notifier).searchShops();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            shopList != null && shopList.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: ListView.builder(
                        itemCount: shopList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            height: 64,
                            child: TextButton(
                                onPressed: () => context.go(
                                    '/${RouteNames.searchShopPage}/${RouteNames.postShopPage}',
                                    extra: shopList[index].placeId),
                                child: Text(
                                  shopList[index].description,
                                  style: const TextStyle(
                                      color: AppColors.appBlack),
                                )),
                          );
                        }),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
