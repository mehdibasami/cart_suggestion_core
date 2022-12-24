
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/core/widgets/custom_select_button.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/image_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/upload/upload_cartsuggestion_image_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/image_preview_item.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UploadCartSuggestionImageScreen extends StatefulWidget {
  UploadCartSuggestionImageScreen(
      {Key? key, this.cartSuggestionId, this.cartSuggestionTitle})
      : super(key: key);
  final int? cartSuggestionId;
  final String? cartSuggestionTitle;
  @override
  State<UploadCartSuggestionImageScreen> createState() =>
      _UploadCartSuggestionImageScreenState();
}

class _UploadCartSuggestionImageScreenState
    extends State<UploadCartSuggestionImageScreen> {
  final UploadCartsuggestionImageController controller =
      Get.put(UploadCartsuggestionImageController());
  @override
  void initState() {
    controller.imageItemsPagingController.addPageRequestListener((pageKey) {
      controller.getCartSuggestionImages(pageKey: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.isRegistered<UploadCartsuggestionImageController>()) {
          Get.delete<UploadCartsuggestionImageController>();
        }
        return true;
      },
      child: Scaffold(
        appBar: SecondAppBar(
            title: widget.cartSuggestionTitle ?? 'آپلود تصویر لینک ها'),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تصویر جدید انتخابی خود را آپلود کنید:',
                style: CustomTypography.title16w600,
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: controller.onTapUploadIcon(),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(5),
                  color: CBase().dinawinBrown,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: GetBuilder<UploadCartsuggestionImageController>(
                      id: 'upload',
                      builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.uploadStatus.status == Status.Loading
                                ? DinawinIndicator()
                                : SvgPicture.asset(Constants.uploadIcon),
                          ],
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'تصویر مورد نظر را از میان تصاویری که قبلا آپلود شده انتخاب کنید:',
                style: CustomTypography.title16w600,
              ),
              const SizedBox(height: 12),

              /// *------ pictures grid view
              Expanded(
                child: GetBuilder<UploadCartsuggestionImageController>(
                  id: 'images',
                  builder: (_) {
                    return DottedBorder(
                      padding: EdgeInsets.all(16),
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      color: CBase().dinawinBrown,
                      child: PagedGridView<int, ImageModel>(
                        pagingController: controller.imageItemsPagingController,
                        addAutomaticKeepAlives: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 133.5 / 96.33,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        builderDelegate: PagedChildBuilderDelegate<ImageModel>(
                          itemBuilder: (context, item, index) {
                            return ImagePreviewItem(
                              imageModel: item,
                              key: Key(item.path),
                              isVideo:
                                  //  item.path.contains('.mp4'),
                                  item.fileType == 'video',
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// *----- submit pictures
              SizedBox(height: 30),
              if (widget.cartSuggestionId != null)
                GetBuilder<UploadCartsuggestionImageController>(
                  id: 'setImageStatus',
                  builder: (_) {
                    return controller.setImageStatus.status == Status.Loading
                        ? Center(
                            child: DinawinIndicator(),
                          )
                        : Center(
                            child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustomSelectButton(
                                title: 'ثبت تصویر انتخاب شده',
                                onTap: () {
                                  controller.onTapSetImageToCartSuggestion(
                                      cartSuggestionImageId:
                                          controller.selectedImageId.value,
                                      cartSuggestionId:
                                          widget.cartSuggestionId ?? 0);
                                },
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                backgroundColor: CBase().dinawinBrown01,
                              ),
                            ),
                          );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
