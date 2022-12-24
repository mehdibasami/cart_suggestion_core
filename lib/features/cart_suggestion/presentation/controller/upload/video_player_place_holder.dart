// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerPlaceHolder extends StatefulWidget {
//   VideoPlayerController controller;
//   VideoPlayerPlaceHolder({
//     required this.controller,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<VideoPlayerPlaceHolder> createState() => _VideoPlayerPlaceHolderState();
// }

// class _VideoPlayerPlaceHolderState extends State<VideoPlayerPlaceHolder> {
//   @override
//   void initState() {
//     super.initState();
//     widget.controller.pause();
//     widget.controller.setLooping(false);
//     widget.controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoPlayer(widget.controller);
//   }
// }
