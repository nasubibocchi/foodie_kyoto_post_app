import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/domain/entity/shop.dart';

class ShopInformationWidget extends StatelessWidget {
  const ShopInformationWidget(
      {Key? key, required this.shop, required this.onTapClose})
      : super(key: key);

  final Shop shop;
  final VoidCallback onTapClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: 400,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onTapClose,
                  child: const Icon(Icons.close, color: AppColors.appBlack),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: shop.images.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child:
                                Image(image: NetworkImage(shop.images[index])),
                          );
                        }),
                  ),
                  const SizedBox(height: 16),
                  FittedBox(
                    child: Text(
                      shop.name,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          color: AppColors.appBlack, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FittedBox(
                    child: Text(
                      shop.comment,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          color: AppColors.appBlack, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.appInactiveButtonBeige,
                      ),
                      icon: const Icon(Icons.add_circle_outline,
                          color: AppColors.appGrey),
                      label: const Text(
                        'メニューを追加',
                        style:
                            TextStyle(color: AppColors.appGrey, fontSize: 16),
                      )),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.appInactiveButtonBeige,
                      ),
                      icon: const Icon(Icons.edit, color: AppColors.appGrey),
                      label: const Text(
                        '編集',
                        style:
                            TextStyle(color: AppColors.appGrey, fontSize: 16),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
