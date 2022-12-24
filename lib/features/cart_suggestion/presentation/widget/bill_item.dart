import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/core/widgets/custom_network_image.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/edit/edit_suggestion_title_page.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/history/cart_history_page.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/select_customer_group_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BillItems extends StatefulWidget {
  final CartSuggestionItemEntity model;
  final Function(int) onDelete;
  final Function(int) enable;
  BillItems({
    Key? key,
    required this.model,
    required this.onDelete,
    required this.enable,
  }) : super(key: key);

  @override
  State<BillItems> createState() => _BillItemsState();
}

class _BillItemsState extends State<BillItems> {
  VideoPlayerController? _videoController;
  bool isVideo = false;
  final CartSuggestionController controller = Get.find();
  @override
  void initState() {
    if (widget.model.imageUrl.contains('.mp4')) {
      isVideo = true;
      _videoController = VideoPlayerController.network(widget.model.imageUrl)
        ..initialize().then((_) {
          _videoController!.setVolume(0);
          _videoController!.pause();
          // Ensure the first frame is shown after the video is initialized.
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Get.to(() => SelectCustomerScreen(
      //         cartSuggestionId: model.id ?? 0,
      //       ));
      // },

      /// *----- links
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CBase().dinawinWhite,
            borderRadius: BorderRadius.circular(5),
          ),
          child: GetBuilder<CartSuggestionController>(
              id: 'delete${widget.model.id ?? 0}',
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 41.5,
                      width: 42.5,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: controller.onTapCartSuggImage(
                                cartSuggestionId: widget.model.id,
                                cartSuggestionTitle: widget.model.title ?? ''),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: widget.model.isActive == true
                                      ? CBase().dinawinBrown01
                                      : CBase().dinawinWhite05,
                                  width: 1,
                                ),
                              ),
                              child: widget.model.isActive == true
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: isVideo
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VideoPlayer(_videoController!),
                                                Icon(
                                                  Icons
                                                      .play_circle_outline_rounded,
                                                  color: CBase().dinawinBrown01,
                                                )
                                              ],
                                            )
                                          : CustomNetworkImage(
                                              imageUrl: widget.model.imageUrl,
                                            ),
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border:
                                        Border.all(color: CBase().pureWhite)),
                                child: widget.model.isActive == true
                                    ? SvgPicture.asset(
                                        'assets/images/add_icon.svg',
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/add_icon.svg',
                                        color: CBase().dinawinWhite05,
                                      )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          widget.model.title ?? 'موضوع',
                          style: TextStyle(
                            color: widget.model.isActive == true
                                ? CBase().dinawinDarkGrey
                                : CBase().dinawinWhite05,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ///
                        /// *----- loading
                        if (_.diactiveStatus.status == Status.Loading)
                          SizedBox(
                              width: 20, height: 20, child: DinawinIndicator()),
                        SizedBox(width: 10),
                        widget.model.isActive == false
                            ? PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                ),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  PopupMenuItem(
                                    child: enableButton(
                                      activate: widget.model.isActive!,
                                      onTap: () {
                                        Get.back();
                                        if (widget.model.isActive == true) {
                                          controller.diactiveCartSuggestion(
                                              widget.model.id ?? 0);
                                        } else {
                                          controller.enableCartSuggestion(
                                              widget.model.id ?? 0);
                                        }
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: CBase().dinawinBrown,
                                      ),
                                      title: Text(
                                        'ویرایش لینک',
                                        style: CustomTypography.dialogContent,
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(
                                          () => EditSuggestionTitlePage(
                                            cartSuggestionId:
                                                widget.model.id ?? 0,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  PopupMenuItem(
                                    child: enableButton(
                                      activate: widget.model.isActive!,
                                      onTap: () {
                                        Get.back();
                                        if (widget.model.isActive == true) {
                                          controller.diactiveCartSuggestion(
                                              widget.model.id ?? 0);
                                        } else {
                                          controller.enableCartSuggestion(
                                              widget.model.id ?? 0);
                                        }
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.share,
                                        color: CBase().dinawinBrown,
                                      ),
                                      title: Text(
                                        'اشتراک گذاری',
                                        style: CustomTypography.dialogContent,
                                      ),
                                      onTap: () {
                                        Get.back();

                                        Get.to(() => SelectCustomerGroupPage(
                                              cartSuggestionId:
                                                  widget.model.id ?? 0,
                                            ));
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: CBase().dinawinBrown,
                                      ),
                                      title: Text(
                                        'ویرایش لینک',
                                        style: CustomTypography.dialogContent,
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(
                                          () => EditSuggestionTitlePage(
                                            cartSuggestionId:
                                                widget.model.id ?? 0,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.history,
                                        color: CBase().dinawinBrown,
                                      ),
                                      title: Text(
                                        'تاریخچه لینک',
                                        style: CustomTypography.dialogContent,
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(CartHistoryPage(
                                          cartSuggestionId:
                                              widget.model.id ?? 0,
                                        ));
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: CBase().dinawinBrown,
                                      ),
                                      title: Text(
                                        'حذف کردن',
                                        style: CustomTypography.dialogContent,
                                      ),
                                      onTap: () {
                                        Get.back();

                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AlertDeleteDialog(
                                                  context,
                                                  onDelete: () {
                                                    widget.onDelete(
                                                        widget.model.id ?? 0);
                                                  },
                                                ));
                                      },
                                    ),
                                  ),
                                  // PopupMenuItem(
                                  //   child: ListTile(
                                  //     leading: Icon(
                                  //       Icons.edit,
                                  //       color: CBase().dinawinBrown,
                                  //     ),
                                  //     title: Text(
                                  //       'ویرایش لینک',
                                  //       style: CustomTypoGraphy.dialogContent,
                                  //     ),
                                  //     onTap: () {
                                  //       Get.back();
                                  //       Get.to(
                                  //         () => EditSuggestionTitlePage(
                                  //           cartSuggestionId: model.id ?? 0,
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                      ],
                    ),
                  ],
                );
              })),
    );
  }

  enableButton({
    required Function onTap,
    required bool activate,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 48,
        decoration: BoxDecoration(
          color: CBase().dinawinDarkGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Text(
              activate == true ? 'غیر فعال سازی' : 'فعال سازی',
              style: TextStyle(
                color: CBase().dinawinWhite,
              ),
            ),
            Spacer(),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: CBase().dinawinWhite,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.power_settings_new,
                  color: CBase().dinawinDarkGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget AlertDeleteDialog(BuildContext context, {required Function() onDelete}) {
  return AlertDialog(
    title: Text('آیا از حذف این مورد اطمینان دارید؟'),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('خیر')),
      TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: Text('بله')),
    ],
  );
}
