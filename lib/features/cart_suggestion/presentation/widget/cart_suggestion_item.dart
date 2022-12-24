import 'dart:async';
import 'dart:developer';

import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/core/widgets/custom_network_image.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/edit_limitation_page.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/custom_radio_button_widget.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CartSuggestionItem extends StatefulWidget {
  const CartSuggestionItem({
    Key? key,
    required this.detailModel,
    this.headBundleDetailModel,
    this.onTapCloseIcon,
    this.makeListModel,
    this.cartHeadBundleRealQty = 0,
    this.subBundleQty = 0,
    this.isSubBundle = false,
    this.islastBundleItem = false,
  }) : super(key: key);
  final CartSuggestionDetailModel detailModel;
  final CartSuggestionItemParams? makeListModel;
  final CartSuggestionDetailModel? headBundleDetailModel;
  final bool isSubBundle;
  final bool islastBundleItem;
  final int cartHeadBundleRealQty;
  final int subBundleQty;
  final void Function()? onTapCloseIcon;
  @override
  State<CartSuggestionItem> createState() => _CartSuggestionItemState();
}

class _CartSuggestionItemState extends State<CartSuggestionItem>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  /// *controller
  VideoPlayerController? _videoController;
  late FlickManager flickManager;
  int? limitationQty;
  int? limitationDay;

  @override
  void initState() {
    super.initState();
    if (widget.detailModel.fileType == FileType.video) {
      /// *video player
      _videoController = VideoPlayerController.network(
        widget.detailModel.productImage ?? '',
      );
      _videoController!.addListener(() {
        // setState(() {});
      });
      _videoController!.setLooping(true);
      _videoController!.initialize().then((_) {});
      _videoController!.play();

      /// *flicked video
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
          widget.detailModel.productImage ?? '',
        ),
      );
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    flickManager.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  final CartSuggestionController cartSuggestionController = Get.find();
  Timer? timer;
  bool isContainBundle = false;
  bool isItemLoading = false;
  final double horizontalMargin = 16;

  @override
  Widget build(BuildContext context) {
    limitationDay = widget.detailModel.limitations
            .firstWhereOrNull(
                (element) => element.profileTypeId == ProfileTypeId.coWorker)
            ?.day ??
        null;
    limitationQty = widget.detailModel.limitations
            .firstWhereOrNull(
                (element) => element.profileTypeId == ProfileTypeId.coWorker)
            ?.qty ??
        null;
    super.build(context);
    final BoxBorder defultBoxBorder =
        Border.all(width: 1, color: CBase().dinawinBrown02);
    isContainBundle = widget.detailModel.bundle != null;
    return GetBuilder<CartSuggestionController>(
        id: 'item_status${widget.detailModel.productId}',
        builder: (_) {
          log('item_status${widget.detailModel.productId}');
          return Column(
            children: [
              Stack(
                children: [
                  //* bundle background
                  if (isContainBundle)
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: horizontalMargin,
                          ),
                          width: double.infinity,
                          height: isContainBundle
                              ? (widget.detailModel.bundle!.items.length + 1) *
                                      276 +
                                  48 +
                                  32
                              : null,
                          decoration: BoxDecoration(
                            color: CBase().dinawinBrown01,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  //** cart contents
                  Column(
                    children: [
                      if (isContainBundle)
                        Container(
                          height: 48,
                          padding: const EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(
                              horizontal: horizontalMargin),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Constants.bundleIcon),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'باندل: ${widget.detailModel.bundle?.title}',
                                style: CustomTypography.title16w600WhiteFull,
                              ),
                            ],
                          ),
                        ),
                      //*cart default contents
                      Container(
                        constraints:
                            const BoxConstraints(minHeight: 276, minWidth: 343),
                        height: 276,
                        decoration: BoxDecoration(
                            color: CBase().dinawinWhiteFull,
                            border: (isContainBundle || widget.isSubBundle)
                                ? null
                                : defultBoxBorder,
                            borderRadius: isContainBundle
                                ? const BorderRadius.vertical(
                                    top: Radius.circular(4))
                                : (widget.isSubBundle &&
                                        !widget.islastBundleItem)
                                    ? null
                                    : widget.islastBundleItem
                                        ? const BorderRadius.vertical(
                                            bottom: Radius.circular(4))
                                        : BorderRadius.circular(4)),
                        padding: const EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(
                          horizontal: (isContainBundle || widget.isSubBundle)
                              ? horizontalMargin + 2
                              : horizontalMargin,
                        ),
                        child: _buildCartContents(),
                      ),

                      //* sub bundle items
                      if (isContainBundle)
                        ListView.builder(
                          itemCount: widget.detailModel.bundle!.items.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                //* subBundel Divider
                                Container(
                                  height: 2,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: horizontalMargin + 2),
                                  decoration: BoxDecoration(
                                    color: CBase().dinawinWhite05,
                                    // border: Border.symmetric(
                                    //   vertical: BorderSide(
                                    //       color: CBase().dinawinBrown01, width: 2),
                                    // ),
                                  ),
                                ),
                                CartSuggestionItem(
                                    isSubBundle: true,
                                    onTapCloseIcon: () {},
                                    islastBundleItem: (index ==
                                        widget.detailModel.bundle!.items
                                                .length -
                                            1),
                                    headBundleDetailModel: widget.detailModel,
                                    cartHeadBundleRealQty:
                                        widget.detailModel.realQty,
                                    subBundleQty: cartSuggestionController
                                        .calculateBundleQty(
                                            realQty:
                                                widget.detailModel.totalQty,
                                            quantity: widget
                                                    .detailModel.multipleQty ??
                                                0,
                                            bundleQty: widget.detailModel
                                                    .bundle!.items[index].qty ??
                                                0),
                                    detailModel: widget
                                        .detailModel.bundle!.items[index]),
                              ],
                            );
                          },
                        ),
                      if (isContainBundle)
                        const SizedBox(
                          height: 32,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget _buildCartContents() {
    int getCashPrice() {
      if (isContainBundle) {
        return widget.detailModel.bundle!.bundlePrices.isEmpty
            ? 0
            : widget.detailModel.bundle!.bundlePrices.first.cash;
      }
      if (widget.isSubBundle) {
        return widget.detailModel.bundlePrices.isEmpty
            ? 0
            : widget.detailModel.bundlePrices.first.cash;
      }
      return widget.detailModel.cashPrice ?? 0;
    }

    int getCreditPrice() {
      if (isContainBundle) {
        return widget.detailModel.bundle!.bundlePrices.isEmpty
            ? 0
            : widget.detailModel.bundle!.bundlePrices.first.credit;
      }
      if (widget.isSubBundle) {
        return widget.detailModel.bundlePrices.isEmpty
            ? 0
            : widget.detailModel.bundlePrices.first.credit;
      }
      return widget.detailModel.creditPrice ?? 0;
    }

    return Column(
      children: [
        SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// *----- productCode
                      Text(
                        widget.detailModel.productCode.toPersianDigit(),
                        style: CustomTypography.title10w400Black02,
                        maxLines: 1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// *----- productName
                                    SizedBox(
                                      height: 24,
                                      child: Text(
                                        widget.detailModel.productName ?? '',
                                        style:
                                            CustomTypography.title16w600Black02,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),

                                    //// *----- brand
                                    SizedBox(
                                      height: 24,
                                      child: Row(
                                        children: [
                                          Text(
                                            'برند:',
                                            style: CustomTypography
                                                .title14w500Brown02,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              (widget.detailModel.brandName ??
                                                  ''),
                                              style: CustomTypography
                                                  .title16w600Black02,
                                            ),
                                          ),
                                          if (widget.detailModel.country !=
                                              null)
                                            Text(
                                              ' - ',
                                              style: CustomTypography
                                                  .title16w600Black02,
                                            ),
                                          if (widget.detailModel.country !=
                                              null)
                                            Text(
                                              (widget.detailModel.country ??
                                                  ''),
                                              style: CustomTypography
                                                  .title16w600Black02,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.detailModel.physicalQty
                                            .toString()
                                            .toPersianDigit(),
                                        style: CustomTypography.title12w400h24,
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'فیزیکی',
                                        style: CustomTypography.title12w400h24,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.detailModel.virtualQty
                                                ?.toString()
                                                .toPersianDigit() ??
                                            '',
                                        style: CustomTypography.title12w400h24,
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'مجازی',
                                        style: CustomTypography.title12w400h24,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),

                          /// *----- vehicles

                          SizedBox(
                            height: 24,
                            child: Text(
                              widget.detailModel.vehicles ?? '',
                              style: CustomTypography.title14w500Black02,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      ///* cart payment ways and text app

                      if (widget.detailModel.isGift)
                        SizedBox(
                          height: 108,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(Constants.gift),
                              Text(
                                'رایـــــــــگان',
                                style: CustomTypography.title14w700Brown02,
                              ),
                            ],
                          ),
                        ),

                      ///* prices
                      if (!widget.detailModel.isGift)
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PriceRowWidget(
                                title: 'نقدی',
                                price: getCashPrice(),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              (widget.isSubBundle || isContainBundle)
                                  ? const SizedBox(
                                      height: 24,
                                    )
                                  : PriceRowWidget(
                                      title: 'اعتباری',
                                      price: getCreditPrice(),
                                      textColor: CBase().dinawinBlack02,
                                    ),
                            ]),

                      const SizedBox(
                        height: 4,
                      ),

                      ///* showTextApp
                      widget.detailModel.showTextApp.isEmpty
                          ? const SizedBox(
                              height: 24,
                            )
                          : Container(
                              height: 24,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: CBase().dinawinWhite02,
                                  borderRadius: BorderRadius.circular(8)),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.detailModel.showTextApp,
                                      style: CustomTypography
                                          .title10w400Black02h18,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          widget.detailModel.showPriceApp
                                              .toString()
                                              .seRagham()
                                              .toPersianDigit(),
                                          style: CustomTypography
                                              .title10w400Black02h18
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      CBase().dinawinBrown01),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text('ریال',
                                            style: CustomTypography
                                                .title10w400Black02h18),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),

                      // SizedBox(
                      //   height: 19,
                      // ),
                    ]),
              ),
              const SizedBox(width: 8),
              Container(
                height: 174,
                width: 1,
                decoration: BoxDecoration(
                    color: CBase().dinawinDarkGrey.withOpacity(0.20)),
              ),
              SizedBox(
                width: 80,
                child: Column(
                  children: [
                    (!widget.isSubBundle && widget.onTapCloseIcon != null)
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              height: 36,
                              width: 36,
                              child: InkWell(
                                onTap: widget.onTapCloseIcon,
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 16,
                                  color: CBase().dinawinBrown02,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 36,
                            width: 36,
                          ),

                    //
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    /// *----- product image

                    widget.detailModel.fileType == FileType.image
                        ? SizedBox(
                            height: 87,
                            child: InkWell(
                              onTap: () {
                                if (widget.detailModel.productImage != null) {
                                  ///
                                  /// *----- full size image
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      var width =
                                          MediaQuery.of(context).size.width;
                                      bool isMobile =
                                          MediaQuery.of(context).size.width >
                                                  700
                                              ? true
                                              : false;
                                      return Dialog(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(25),
                                                width: isMobile
                                                    ? width / 1.5
                                                    : width / 2,
                                                height: isMobile
                                                    ? width / 1.5
                                                    : width / 2,
                                              ),
                                            ),
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(25),
                                                width: isMobile
                                                    ? width / 1.5
                                                    : width / 2,
                                                height: isMobile
                                                    ? width / 1.5
                                                    : width / 2,
                                                decoration: BoxDecoration(
                                                  color:
                                                      CBase().dinawinWhiteFull,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: CustomNetworkImage(
                                                  imageUrl: widget
                                                      .detailModel.productImage
                                                      .toString(),
                                                  // fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: widget.detailModel.productImage == null
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: SvgPicture.asset(
                                        Constants.imagePlaceholder,
                                      ),
                                    )
                                  : CustomNetworkImage(
                                      imageUrl:
                                          widget.detailModel.productImage ?? '',
                                    ),
                            ),
                          )

                        /// *video player
                        : Container(
                            margin: const EdgeInsets.only(right: 5),
                            color: CBase().dinawinBlack03.withOpacity(0.5),
                            width: 80,
                            height: 80,
                            child: Stack(
                              children: [
                                if (_videoController != null)
                                  VideoPlayer(_videoController!),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: FlickVideoPlayer(
                                              flickManager: flickManager,
                                              flickVideoWithControls:
                                                  FlickVideoWithControls(
                                                videoFit: BoxFit.fitWidth,
                                                controls: FlickPortraitControls(
                                                  progressBarSettings:
                                                      FlickProgressBarSettings(
                                                    playedColor: Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    log('its a video!!!');
                                  },
                                  child: const SizedBox(
                                    height: 80,
                                    width: 80,
                                  ),
                                )
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 32,
                      child: SvgPicture.network(
                        widget.detailModel.brandImage.toString(),
                        height: 32,
                        width: 32,
                      ),
                    ),

                    ///*----Garrantie Logo
                    widget.detailModel.isProductGarrantied
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 77, 2, 2),
                                    Color.fromARGB(255, 255, 51, 51),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  // stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Text(
                              'رایان گارانتی',
                              style: TextStyle(
                                  color: CBase().pureWhite, fontSize: 12),
                            ),
                          )
                        : const SizedBox(height: 32),
                  ],
                ),
              )
            ],
          ),
        ),

        ///* horzontal divider
        Container(
          height: 1,
          width: double.infinity,
          decoration:
              BoxDecoration(color: CBase().dinawinDarkGrey.withOpacity(0.20)),
        ),

        /// *
        SizedBox(
          height: 3,
        ),
        SizedBox(
          height: 52,
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 18,
                    child: Text(
                      'محدودیت فروش',
                      style: CustomTypography.title10w400Black02h18,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 16,
                            child: Text(
                              '${limitationQty?.toString().toPersianDigit() ?? '--'}' +
                                  ' عدد',
                              style: CustomTypography.title8w400Black02h16,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 1,
                            color: CBase().dinawinWhite05,
                          ),
                          SizedBox(
                            height: 16,
                            child: Text(
                              '${limitationDay?.toString().toPersianDigit() ?? '--'}' +
                                  ' روز',
                              style: CustomTypography.title8w400Black02h16,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      InkWell(
                        onTap: () {
                          if (widget.detailModel.limitations.isNotEmpty) {
                            Get.dialog(
                              EditLimitationPage(
                                  cartSuggestionDetailEntity:
                                      widget.detailModel),
                            ).then((value) {
                              setState(() {});
                            });
                          } else {
                            Fluttertoast.showToast(
                              gravity: ToastGravity.CENTER,
                              msg: 'لیست محدودیت فروش خالی است',
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(Constants.settingsIcon),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 33,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 18,
                    child: Text(
                      'سرگروه باندل',
                      style: CustomTypography.title10w400Black02h18,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRadioButton(isSelected: isContainBundle),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 33,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 18,
                    child: Text(
                      'زیرگروه باندل',
                      style: CustomTypography.title10w400Black02h18,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRadioButton(isSelected: widget.isSubBundle),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 33,
              ),
              if (widget.makeListModel != null)
                Expanded(
                  child: Center(
                    child: switchBtn(
                        isSelected: (widget.makeListModel!.details.any(
                            (element) =>
                                element.productId ==
                                (widget.detailModel.productId ?? -1)))),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  switchBtn({
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        bool _isExistInBundle = false;
        log('  selected product: ${widget.detailModel.productId} ');

        for (CartSuggestionDetailModel itemAdded
            in widget.makeListModel!.details) {
          ///* is it contain bundle and  itemes of this bundle exist in basket
          if (widget.detailModel.bundle != null &&
              widget.detailModel.bundle!.items.any((bundleItemOfCurrent) =>
                  (bundleItemOfCurrent.productId == itemAdded.productId))) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              backgroundColor: CBase().dinawinBrown01,
              gravity: ToastGravity.CENTER,
              msg:
                  'حداقل یکی از آیتم های این باندل به صورت جداگانه به سبد اضافه شده است',
            );

            return;
          }

          ///* check if items of basket have bundle and its bundle items contain this current selcetd item
          if (itemAdded.bundle != null) {
            _isExistInBundle = itemAdded.bundle!.items.any((bundleItem) =>
                (bundleItem.productId == widget.detailModel.productId));
          }
        }
        if (_isExistInBundle) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            gravity: ToastGravity.CENTER,
            backgroundColor: CBase().dinawinBrown01,
            msg: 'این کالا در باندل وجود دارد',
          );
        } else {
          onUpdate(
            widget.detailModel,
            (widget.makeListModel!.details.any((element) =>
                element.productId == (widget.detailModel.productId ?? -1))),
          );
          setState(() {});
        }
      },
      child: Container(
        width: CBase().dinawinWidth(context) / 12,
        height: CBase().dinawinWidth(context) / 12,
        // color: Colors.red,
        child: Container(
          width: CBase().dinawinWidth(context) / 12,
          height: CBase().dinawinWidth(context) / 12,
          decoration: BoxDecoration(
            color: isSelected ? CBase().dinawinBrown01 : CBase().dinawinWhite,
            borderRadius: BorderRadius.circular(5),
            border: isSelected
                ? null
                : Border.all(color: CBase().dinawinBrown01, width: 1),
          ),
          child: Center(
            child: Icon(
              isSelected ? Icons.check : Icons.add,
              color: isSelected ? CBase().dinawinWhite : CBase().dinawinBrown01,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget profitPercent() {
    int _cash = widget.detailModel.cashPrice ?? 0;
    int _credit = widget.detailModel.creditPrice ?? 0;
    if (_cash < _credit && _credit != 0 && _cash != 0) {
      int _percent = ((1 - (_cash / _credit)) * 100).toInt();
      return Text(
        '(-${_percent.toString().toPersianDigit()}%)',
        style: CustomTypography.percent12w700Green01,
        textDirection: TextDirection.ltr,
      );
    } else {
      return const SizedBox();
    }
  }

  void onUpdate(CartSuggestionDetailModel p, bool isSelected) {
    if (isSelected) {
      /// remove item from list
      _remove(p);
    } else {
      /// item doesn't exist in the list
      _add(p);
    }
  }

  void _add(CartSuggestionDetailModel p) {
    widget.makeListModel!.details.add(p);
  }

  void _remove(CartSuggestionDetailModel p) {
    widget.makeListModel!.details
        .removeWhere((element) => element.productId == p.productId);
  }
}

class PriceRowWidget extends StatelessWidget {
  const PriceRowWidget({
    Key? key,
    required this.price,
    required this.title,
    this.textColor,
  }) : super(key: key);
  final String title;
  final int price;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                CustomTypography.title14w500Brown02.copyWith(color: textColor),
          ),
          Row(
            children: [
              Text(
                price.toString().seRagham().toPersianDigit(),
                style: CustomTypography.title16w500Brown02
                    .copyWith(color: textColor),
              ),
              const SizedBox(width: 4),
              Text(
                'ریال',
                style: CustomTypography.title16w500Brown02
                    .copyWith(color: textColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
