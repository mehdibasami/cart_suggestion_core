
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/widgets/custom_tabbar_widget.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/core/widgets/not_found_widget.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_history_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/history/cart_history_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartHistoryPage extends StatefulWidget {
  CartHistoryPage({Key? key, required this.cartSuggestionId}) : super(key: key);
  final int cartSuggestionId;

  @override
  State<CartHistoryPage> createState() => _CartHistoryPageState();
}

class _CartHistoryPageState extends State<CartHistoryPage> {
  int _selectedTabs = 0;
  bool isInit = true;

  @override
  void initState() {
    controller.notSendedPagingController.addPageRequestListener((pageKey) {
      controller.getUserGroupsNotSendedSuggestion(
          pageKey: pageKey, cartSuggestionId: widget.cartSuggestionId);
    });

    controller.sendedPagingController.addPageRequestListener((pageKey) {
      controller.getUserGroupsRecivedSuggestion(
          pageKey: pageKey, cartSuggestionId: widget.cartSuggestionId);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.sendedPagingController.dispose();
    controller.notSendedPagingController.dispose();
    super.dispose();
  }

  final CartHistoryController controller = Get.put(
    CartHistoryController(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        Get.delete<CartHistoryController>();
        return true;
      }),
      child: Scaffold(
        backgroundColor: CBase().dinawinBackGround,
        appBar: SecondAppBar(title: 'تاریخچه لینک'),
        body: Column(children: [
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CustomTabBarWidget(
                    isSelected: _selectedTabs == 0,
                    title: 'ارسال شده',
                    onTap: () {
                      setState(() {
                        _selectedTabs = 0;
                      });
                    }),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: CustomTabBarWidget(
                    isSelected: _selectedTabs == 1,
                    title: 'ارسال نشده',
                    onTap: () {
                      setState(() {
                        _selectedTabs = 1;
                      });
                      if (isInit) {
                        controller.getUserGroupsNotSendedSuggestion(
                            pageKey: 1,
                            cartSuggestionId: widget.cartSuggestionId);
                        isInit = false;
                      }
                    }),
              ),
            ],
          ).marginAll(8),
          if (_selectedTabs == 0)
            Expanded(
                child: Obx(
              () => controller.emptySendedList.value
                  ? NotFoundWidget(
                      onPressedTryAgain: controller.onPressSendedTryAgain,
                    )
                  : PagedListView<int, CartHistoryModel>(
                      pagingController: controller.sendedPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<CartHistoryModel>(
                        itemBuilder: (context, item, index) => Container(
                            margin: controller.sendedPagingController.itemList!
                                            .length -
                                        1 ==
                                    index
                                ? EdgeInsets.only(
                                    bottom: 50, top: 8, left: 8, right: 8)
                                : EdgeInsets.all(8),
                            decoration: _buildBoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text('نام گروه: '),
                                        Expanded(
                                            child: Text(
                                          '${item.userGroupName}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('تاریخ: '),
                                      Text(
                                          '${item.sendedDateTime?.toPersianDate().toEnglishDigit() ?? ''}'),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
            )),
          if (_selectedTabs == 1)
            Expanded(
                child: Obx(
              () => controller.emptyNotSendedList.value
                  ? NotFoundWidget(
                      onPressedTryAgain: controller.onPressNotSendedTryAgain,
                    )
                  : PagedListView<int, CartHistoryModel>(
                      pagingController: controller.notSendedPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<CartHistoryModel>(
                        itemBuilder: (context, item, index) => Container(
                            margin: controller.notSendedPagingController
                                            .itemList!.length -
                                        1 ==
                                    index
                                ? EdgeInsets.only(
                                    bottom: 50, top: 8, left: 8, right: 8)
                                : EdgeInsets.all(8),
                            decoration: _buildBoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text('نام گروه: '),
                                  Expanded(
                                      child: Text(
                                    '${item.userGroupName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  GetBuilder<CartHistoryController>(
                                      id: '${item.userGroupId}',
                                      builder: (context) {
                                        return controller.loadingShareBtn
                                            ? Center(
                                                child: DinawinIndicator(),
                                              )
                                            : InkWell(
                                                onTap:
                                                    controller.onPressShareBtn(
                                                        cartSuggestionId: widget
                                                            .cartSuggestionId,
                                                        selectedGroupId:
                                                            item.userGroupId ??
                                                                0),
                                                child: Icon(
                                                  Icons.share,
                                                  size: 28,
                                                ));
                                      })
                                ],
                              ),
                            )),
                      ),
                    ),
            ))
        ]),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8));
  }
}
