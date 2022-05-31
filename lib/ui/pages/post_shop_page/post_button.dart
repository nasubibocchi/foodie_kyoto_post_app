import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/components/select_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostButton extends ConsumerWidget {
  const PostButton({Key? key, required this.shopId}) : super(key: key);

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () async {
          HapticFeedback.mediumImpact();
          await showDialog(
              context: context,
              builder: (context) {
                return SelectDialog(
                  null,
                  body: 'お店を登録します',
                  onPressed: () {
                    ref
                        .read(postShopProvider(shopId).notifier)
                        .postShop()
                        .then((postResults) async {
                      final String body;
                      final String title;
                      switch (postResults) {
                        case PostResults.success:
                          body = '登録に成功しました。';
                          title = 'SUCCESS!';
                          break;
                        case PostResults.empty:
                          body = 'コメントと画像は設定してね';
                          title = 'BLANK';
                          break;
                        case PostResults.abort:
                          body = '準備が整っていなかった';
                          title = 'ABORT';
                          break;
                        case PostResults.error:
                          body = 'エラーが起きました';
                          title = 'ERROR';
                          break;
                        default:
                          body = '';
                          title = '';
                          break;
                      }

                      await showDialog(
                          context: context,
                          builder: (context) {
                            return OkDialog(title: title, body: body);
                          });
                    }).then((_) => Navigator.of(context).pop());
                  },
                );
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
        ));
  }
}
