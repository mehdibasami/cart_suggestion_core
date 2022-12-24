
import 'package:cart_suggestion_core/core/widgets/not_found_widget.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_history_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/history/group_history_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class GroupHistoryPage extends StatefulWidget {
  GroupHistoryPage(
      {Key? key, required this.userGroupId, required this.userGroupName})
      : super(key: key);
  final int userGroupId;
  final String userGroupName;

  @override
  State<GroupHistoryPage> createState() => _GroupHistoryPageState();
}

class _GroupHistoryPageState extends State<GroupHistoryPage> {
  final GroupHistoryController controller = Get.put(
    GroupHistoryController(),
  );
  @override
  void initState() {
    controller.suggestionSendedUserGroupsPagingController
        .addPageRequestListener((pageKey) {
      controller.getSuggestionSendedUserGroups(
          pageKey: pageKey, userGroupId: widget.userGroupId);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.suggestionSendedUserGroupsPagingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        Get.delete<GroupHistoryController>();
        return true;
      }),
      child: Scaffold(
        appBar: SecondAppBar(title: 'تاریخچه گروه ${widget.userGroupName}'),
        body: Column(children: [
          Expanded(
            child: Obx(
              () => controller.emptySuggestionSendedList.value
                  ? Center(
                      child: NotFoundWidget(
                        onPressedTryAgain:
                            controller.onPressSuggestionSendedTryAgain,
                      ),
                    )
                  : PagedListView<int, CartHistoryModel>(
                      pagingController:
                          controller.suggestionSendedUserGroupsPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<CartHistoryModel>(
                        itemBuilder: (context, item, index) => Container(
                            margin:
                                controller.suggestionSendedUserGroupsPagingController
                                                .itemList!.length -
                                            1 ==
                                        index
                                    ? EdgeInsets.only(
                                        bottom: 50, top: 8, left: 8, right: 8)
                                    : EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    '${item.suggestionName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
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
            ),
          )
        ]),
      ),
    );
  }
}
