import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/ui/components/ok_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/components/select_dialog.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_menu_page/post_menu_provider.dart';
import 'package:foodie_kyoto_post_app/ui/pages/post_shop_page/post_shop_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

class PostButton extends ConsumerWidget {
  const PostButton(this.scaffoldKey,
      {Key? key, required this.shopId, required this.menu})
      : super(key: key);

  final String shopId;
  final Menu? menu;
  final GlobalKey scaffoldKey;

  Future<bool> _canExecutePost(context) async {
    bool canExecute = false;
    await showDialog<bool>(
        context: (context),
        builder: (selectContext) {
          return SelectDialog(null, body: 'メニューを登録します', onPressed: () {
            canExecute = true;
            Navigator.of(selectContext).pop();
          });
        });
    return canExecute;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () async {
          HapticFeedback.mediumImpact();
          final canExecute = await _canExecutePost(context);
          if (canExecute) {
            await ref
                .read(postMenuProvider(Tuple2(shopId, menu)).notifier)
                .createOrModifyMenu()
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
                  context: scaffoldKey.currentContext!,
                  builder: (context) {
                    return OkDialog(title: title, body: body);
                  });
            });
          }
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
