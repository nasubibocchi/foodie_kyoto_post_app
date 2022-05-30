import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';

// ひとまずtagButtonと同じデザインで作る
class UserButton extends StatelessWidget {
  const UserButton(
      {Key? key,
      required this.onTap,
      required this.onTapCloseIcon,
      required this.userName,
      required this.isSelected})
      : super(key: key);

  final VoidCallback onTap;
  final VoidCallback onTapCloseIcon;
  final String userName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSelected ? onTapCloseIcon : onTap,
      style: ElevatedButton.styleFrom(
        primary: isSelected
            ? AppColors.appActiveButtonBeige
            : AppColors.appInactiveButtonBeige,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userName,
              style: const TextStyle(color: AppColors.appGrey, fontSize: 16),
            ),
            isSelected
                ? Row(
                    children: [
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onTapCloseIcon,
                        child: const Icon(
                          Icons.close,
                          color: AppColors.appGrey,
                          size: 18,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ]),
    );
  }
}
