import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';

class OkDialog extends StatelessWidget {
  const OkDialog({required this.title, required this.body, Key? key})
      : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            color: AppColors.appBlack,
            fontWeight: FontWeight.bold),
      ),
      titlePadding: const EdgeInsets.all(24),
      content: SingleChildScrollView(
        child: Center(
          child: Text(
            body,
            style: const TextStyle(fontSize: 14, color: AppColors.appBlack),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text(
            'OK',
            style: TextStyle(
                color: AppColors.appBlack, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
