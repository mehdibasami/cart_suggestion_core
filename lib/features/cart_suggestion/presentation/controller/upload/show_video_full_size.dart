// ignore_for_file: must_be_immutable

import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoFullSize extends StatefulWidget {
  String videoPath;
  VideoPlayerController videoPlayerController;
  ShowVideoFullSize({
    required this.videoPath,
    required this.videoPlayerController,
    Key? key,
  }) : super(key: key);

  @override
  State<ShowVideoFullSize> createState() => _ShowVideoFullSizeState();
}

class _ShowVideoFullSizeState extends State<ShowVideoFullSize> {
  // late final VideoPlayerController _videoController;
  // late bool loading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   if (mounted) {
  //     _videoController = VideoPlayerController.network(widget.videoPath);

  //     _videoController.addListener(() {
  //       // setState(() {});
  //     });
  //     _videoController.setLooping(true);
  //     _videoController.initialize().then((_) {});
  //     _videoController.play();
  //   }
  // }

  // @override
  // void dispose() {
  //   _videoController.dispose();
  //   super.dispose();
  // }
  late FlickManager flickManager;
  @override
  void initState() {
    flickManager = FlickManager(
        videoPlayerController: widget.videoPlayerController, autoPlay: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CBase().dinawinDarkGrey,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(40),
            color: Colors.red,
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: FlickVideoPlayer(flickManager: flickManager)),

            // child: VideoPlayer(widget.videoPlayerController),
          ),
        ),
      ),
    );
  }
}
