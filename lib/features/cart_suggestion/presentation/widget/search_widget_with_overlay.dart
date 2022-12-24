import 'dart:async';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/widgets/FullCheckBox.dart';
import 'package:cart_suggestion_core/core/widgets/SearchSpeech.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/overlay_search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidgetWithOverlay extends StatefulWidget {
  SearchWidgetWithOverlay(
      {this.searchCallBack, required this.vehicleIds, required this.brandIds});

  final Function(String searchText)? searchCallBack;
  final List<int> vehicleIds;
  final List<int> brandIds;
  @override
  State<SearchWidgetWithOverlay> createState() =>
      _SearchWidgetWithOverlayState();
}

class _SearchWidgetWithOverlayState extends State<SearchWidgetWithOverlay>
    with SingleTickerProviderStateMixin {
  static GlobalKey key = GlobalKey();
  static const double _height = 50;
  static const double _horizPad = 30;
  static const double _boxVertPad = 0;
  static AnimationController? animationController;
  static Animation<double>? animation;
  static OverlayEntry? overlayEntry;

  Timer? timer;

  static bool boxVisibility = false;

  TextEditingController controller = TextEditingController();

  OverlaySearchController searchController = Get.put(OverlaySearchController());

  @override
  void initState() {
    super.initState();
    searchController.vehicles = widget.vehicleIds;
    searchController.brands = widget.brandIds;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _hideBox();
        return true;
      },
      child: Container(
        // key: key,
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: CBase().getFullHeight(context) / 17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: CBase().pureWhite,
        ),
        child: Row(
          key: key,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'سرچ'.tr,
                    hintStyle: TextStyle(
                      color: CBase().dinawinDarkGrey.withOpacity(0.25),
                      fontSize: 14,
                    ),
                    icon: Icon(
                      CupertinoIcons.search,
                      color: CBase().dinawinDarkGrey.withOpacity(0.25),
                    )),
                style: TextStyle(
                  fontSize: 14,
                  color: CBase().dinawinDarkGrey,
                ),
                onChanged: (value) async {
                  if (timer != null) timer!.cancel();
                  if (value.length > 0) {
                    searchController.updateClear();
                  }
                  timer = Timer(const Duration(milliseconds: 700), () {
                    if (value.length >= 2) {
                      searchController.searchParts(
                          brandIds: widget.brandIds,
                          searchText: value,
                          vehicleIds: widget.vehicleIds);
                      if (!boxVisibility) {
                        _showBox(context);
                      }
                    }
                  });

                  // if (onSearch != null) {
                  //   if (timer != null) timer!.cancel();
                  //   timer = Timer(const Duration(milliseconds: 700),
                  //       () => onSearch!(value));
                  // }
                },
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: GetBuilder<OverlaySearchController>(
                  id: 'clear',
                  builder: (logic) {
                    return Visibility(
                      visible: controller.text.isNotEmpty,
                      child: InkWell(
                          onTap: () {
                            controller.text = '';
                            searchController.updateClear();
                            // searchController.clearText();
                          },
                          child: Icon(Icons.clear)),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
              child: VerticalDivider(
                color: CBase().dinawinDarkGrey.withOpacity(0.5),
                width: 0.5,
                thickness: 0.5,
              ),
            ),
            SearchSpeech(
              speechTextCallBack: (result) {
                controller.text = result;
                searchController.update(['clear']);
                if (timer != null) timer!.cancel();
                timer = Timer(const Duration(milliseconds: 700), () {
                  if (result.length >= 2) {
                    searchController.searchParts(
                        brandIds: widget.brandIds,
                        searchText: result,
                        vehicleIds: widget.vehicleIds);
                    if (!boxVisibility) {
                      _showBox(context);
                    }
                  }
                });
                // controller.text = result;
                // if (timer != null) timer!.cancel();
                // _search();
                // searchController.update(['clear']);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBox(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTapDown: (v) {
              controller.text = '';
              searchController.updateClear();
              _hideBox();
            },
            child: Container(
              width: CBase().getFullWidth(context),
              height: CBase().getFullHeight(context),
              color: Colors.transparent,
            ),
          ),
          Positioned(
            right: getPosition().dx - 10,
            top: getPosition().dy + _height + _boxVertPad,
            child: FadeTransition(
              opacity: animation!,
              child: TheBox(
                height: _height,
                horizPad: _horizPad,
                controller: controller,
                onSelect: () {
                  controller.text = '';
                  searchController.updateClear();
                  _hideBox();
                  // _controller.text = '';
                },
              ),
            ),
          ),
        ],
      );
    });
    animationController!.addListener(() {
      overlayState!.setState(() {});
    });
    // inserting overlay entry
    overlayState!.insert(overlayEntry!);
    animationController!.forward();
    boxVisibility = true;
    // await Future.delayed(const Duration(seconds: 3))
    //     .whenComplete(() => animationController!.reverse())
    //     // removing overlay entry after stipulated time.
    //     .whenComplete(() => overlayEntry.remove());
  }

  Offset getPosition() {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    return position;
  }

  void _hideBox() {
    animationController!.reverse().whenComplete(() => overlayEntry!.remove());
    boxVisibility = false;
  }
}

class TheBox extends StatelessWidget {
  TheBox(
      {Key? key,
      required this.horizPad,
      required this.height,
      required this.onSelect,
      required this.controller})
      : super(key: key);

  final double horizPad;
  final double height;
  final Function() onSelect;
  final TextEditingController controller;

  final OverlaySearchController _overlaySearchController =
      Get.put(OverlaySearchController());
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      elevation: 1,
      color: CBase().pureWhite,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: CBase().getFullWidth(context) - (horizPad * 2),
        height: CBase().getFullHeight(context) / 3.5,
        child: GetBuilder<OverlaySearchController>(
          id: 'loading_search',
          builder: (_) {
            if (_overlaySearchController.productStatus.status ==
                Status.Loading) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xffff0000),
                  ),
                  backgroundColor: Color(0xFF2C2C2C),
                ),
              );
            } else if (_overlaySearchController.productStatus.status ==
                Status.Error) {
              return Center(
                child: Text(_overlaySearchController.productStatus.message),
              );
            } else if (_overlaySearchController.productStatus.status ==
                Status.Success) {
              return _overlaySearchController.searchedItems.isNotEmpty
                  ? Column(
                      children: [
                        GetBuilder<OverlaySearchController>(
                            id: 'searchItem',
                            builder: (logic) {
                              return Expanded(
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: _overlaySearchController
                                        .searchedItems.length,
                                    padding: const EdgeInsets.only(top: 5),
                                    itemBuilder: (context, index) {
                                      bool selectedItem =
                                          _overlaySearchController.selectedItem
                                              .any((element) =>
                                                  (element.partId ==
                                                      _overlaySearchController
                                                          .searchedItems[index]
                                                          .partId));
                                      // .any(_overlaySearchController
                                      //     .searchedItems[index]);
                                      return InkWell(
                                        onTap: () {
                                          if (selectedItem == true) {
                                            _overlaySearchController.removeItem(
                                                _overlaySearchController
                                                    .searchedItems[index]);
                                          } else {
                                            _overlaySearchController.addItem(
                                                _overlaySearchController
                                                    .searchedItems[index]);
                                          }
                                          // _overlaySearchController.filterCustomer(
                                          //     _overlaySearchController.customers[index]);
                                          // onSelect();
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              top: 10),
                                                      child: Text(
                                                        _overlaySearchController
                                                                .searchedItems[
                                                                    index]
                                                                .partName ??
                                                            'بدون نام',
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                _overlaySearchController
                                                            .searchedItems[
                                                                index]
                                                            .keyWord !=
                                                        null
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 2,
                                                                horizontal: 5),
                                                        margin: const EdgeInsets
                                                            .only(right: 5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: CBase()
                                                                .dinawinBrown
                                                                .withOpacity(
                                                                    0.2)),
                                                        child: Text(
                                                          _overlaySearchController
                                                                  .searchedItems[
                                                                      index]
                                                                  .keyWord ??
                                                              '',
                                                          style: TextStyle(
                                                              color: CBase()
                                                                  .dinawinBrown,
                                                              fontSize: 10),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: FullCheckBox(
                                                      value: selectedItem),
                                                )
                                              ],
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    }),
                              );
                            }),
                        Container(
                          child: InkWell(
                            onTap: () {
                              if (_overlaySearchController
                                  .searchedItems.isNotEmpty) {
                                controller.text = '';
                                _overlaySearchController.update(['clear']);
                                _overlaySearchController.confirm();
                                onSelect();
                              } else {
                                Snacki().GETSnackBar(
                                    false, 'لطفا یک محصول را انتخاب کنید'.tr);
                              }
                            },
                            child: Material(
                              elevation: 5,
                              color: CBase().basePrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15),
                                child: Text(
                                  'مشاهده',
                                  style: TextStyle(
                                    fontSize: CBase().getTextfontSizeByScreen(),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ).tr(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text('مشتری یافت نشد'),
                    );
            } else {
              return const Center(
                child: Text('حداقل دو حرف وارد کنید.'),
              );
            }
          },
        ),
      ),
    );
  }
}
