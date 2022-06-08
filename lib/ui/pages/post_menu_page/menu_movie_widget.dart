import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie_kyoto_post_app/constants/app_colors.dart';
import 'package:foodie_kyoto_post_app/domain/entity/menu.dart';
import 'package:foodie_kyoto_post_app/ui/components/select_dialog.dart';
import 'package:video_player/video_player.dart';

class MenuMovieWidget extends StatefulWidget {
  const MenuMovieWidget(
      {Key? key,
      required this.shopId,
      required this.movies,
      required this.onTapDeleteMovie,
      required this.onTapAddMovie,
      this.menu})
      : super(key: key);

  final String shopId;
  final Menu? menu;
  final File? movies;

  final VoidCallback onTapDeleteMovie;
  final VoidCallback onTapAddMovie;

  @override
  State<MenuMovieWidget> createState() => _MenuMovieWidgetState();
}

class _MenuMovieWidgetState extends State<MenuMovieWidget> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(MenuMovieWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.movies != null && oldWidget.movies != widget.movies) {
      videoController = VideoPlayerController.file(widget.movies!)
        ..initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.movies != null
        ? GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return SelectDialog(
                      '動画を削除',
                      body: '選択した動画を削除します',
                      onPressed: widget.onTapDeleteMovie,
                    );
                  });
            },
            child: SizedBox(
              height: 352,
              width: 176,
              child: videoController != null
                  ? Stack(children: [
                      VideoPlayer(videoController!),
                      videoController!.value.isPlaying
                          ? Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () => setState(() {
                                        videoController!.pause();
                                      }),
                                  icon: const Icon(Icons.stop_circle_rounded,
                                      size: 36)),
                            )
                          : Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () => setState(() {
                                        videoController!.play();
                                      }),
                                  icon: const Icon(
                                      Icons.play_circle_fill_rounded,
                                      size: 36)),
                            ),
                    ])
                  : const SizedBox(),
            ),
          )
        : GestureDetector(
            onTap: widget.onTapAddMovie,
            child: Container(
              height: 100,
              width: 350,
              decoration: const BoxDecoration(color: AppColors.appBeige),
              child: const Center(
                child: Text(
                  'タップして動画を追加',
                  style: TextStyle(color: AppColors.appBlack),
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    videoController?.dispose();
  }
}
