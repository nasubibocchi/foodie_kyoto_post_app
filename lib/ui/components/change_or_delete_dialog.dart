import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';

class ChangeOrDeleteDialog extends StatelessWidget {
  const ChangeOrDeleteDialog(
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
