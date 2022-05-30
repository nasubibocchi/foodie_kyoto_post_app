import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';

class SelectDialog extends StatelessWidget {
  const SelectDialog(this.title,
      {Key? key, required this.body, required this.onPressed})
      : super(key: key);

  final String? title;
  final String body;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(color: AppColors.appBlack),
            )
          : const SizedBox(),
      content: Text(
        body,
        style: const TextStyle(color: AppColors.appBlack),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
