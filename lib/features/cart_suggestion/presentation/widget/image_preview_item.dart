import 'dart:developer';

import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:cart_suggestion_core/core/widgets/custom_network_image.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/core/widgets/show_image_full_slider.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/image_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/upload/show_video_full_size.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/upload/upload_cartsuggestion_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class ImagePreviewItem extends StatefulWidget {
  final ImageModel imageModel;
  final bool isVideo;
  ImagePreviewItem({
    Key? key,
    required this.imageModel,
    this.isVideo = false,
  }) : super(key: key);

  @override
  State<ImagePreviewItem> createState() => _ImagePreviewItemState();
}

class _ImagePreviewItemState extends State<ImagePreviewItem>
    with AutomaticKeepAliveClientMixin {
  final UploadCartsuggestionImageController controller = Get.find();
  @override
  bool get wantKeepAlive => true;

  ///
  /// *controller
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      log('videoUrl: ${widget.imageModel.path}');
      _videoController = VideoPlayerController.network(widget.imageModel.path)
        ..initialize().then((_) {
          _videoController.setVolume(0);
          _videoController.pause();
          // Ensure the first frame is shown after the video is initialized.
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return InkWell(
          borderRadius: BorderRadius.circular(4),
          onLongPress: controller.onLongPressImage(id: widget.imageModel.id),
          onTap: controller.onTapImage(
              id: widget.imageModel.id,
              imageUrl: widget.imageModel.path,
              goTo: () async {
                widget.isVideo
                    ? Get.to(() => ShowVideoFullSize(
                          videoPath: widget.imageModel.path,
                          videoPlayerController: _videoController,
                        ))
                    : Get.to(() =>
                        ShowImageFullSize(imageUrl: widget.imageModel.path));
              }),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              // margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: CBase().dinawinBrown01)),
              child: Stack(
                children: [
                  widget.isVideo == true
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            VideoPlayer(_videoController),
                            Icon(
                              Icons.play_circle_outline_rounded,
                              color: CBase().dinawinBrown01,
                              size: 32,
                            )
                          ],
                        )
                      : Center(
                          child: CustomNetworkImage(
                            imageUrl: widget.imageModel.path,
                          ),
                        ),
                  if (controller.selectedImageId.value == widget.imageModel.id)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: CBase().dinawinBlack01.withOpacity(0.5),
                      ),
                    ),
                  if (controller.selectedImageId.value == widget.imageModel.id)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: GetBuilder<UploadCartsuggestionImageController>(
                        id: 'deleteImage${controller.selectedImageId.value}',
                        builder: (context) {
                          return controller.deleteImageStatus.status ==
                                  Status.Loading
                              ? Container(
                                  margin: const EdgeInsets.all(10.0),
                                  height: 12,
                                  width: 12,
                                  child: DinawinIndicator(),
                                )
                              : InkWell(
                                  onTap: () {
                                    controller.onTapDeleteIcon(
                                      cartSuggestionImageId:
                                          controller.selectedImageId.value,
                                    );
                                  },
                                  onLongPress: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                        SvgPicture.asset(Constants.deleteIcon),
                                  ),
                                );
                        },
                      ),
                    ),
                  if (controller.selectedImageId.value == widget.imageModel.id)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(Constants.checkedIcon),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
