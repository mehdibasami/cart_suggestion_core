import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/edit/edit_suggestion_title_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/overlay_search_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/edit/edit_checkall_suggestion.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/chosen_part_item.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/custom_dark_btn.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/search_widget_with_overlay.dart';

class EditChooseProductScreen extends StatelessWidget {
  final CartSuggestionItemParams makeListModel;

  EditChooseProductScreen({
    Key? key,
    required this.makeListModel,
  }) : super(key: key);

  final OverlaySearchController _overlaySearchController =
      Get.put(OverlaySearchController());
  final EditCartSuggestionController editCartSuggestionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Get.isRegistered<OverlaySearchController>()) {
          Get.delete<OverlaySearchController>();
        }
        // makeListModel.chosenProduct = [];
        return Future.value(true);
      },
      child: Scaffold(
        appBar: SecondAppBar(
          title: 'انتخاب محصول'.tr,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    SearchWidgetWithOverlay(
                      vehicleIds:
                          editCartSuggestionController.selectedVehicleIds,
                      brandIds: editCartSuggestionController.selectedBrandIds,
                      searchCallBack: ((searchText) {}),
                    ),
                    SizedBox(height: 15),
                    GetBuilder<OverlaySearchController>(
                        id: 'items',
                        builder: (logic) {
                          return _overlaySearchController.itemsStatus.status ==
                                  Status.NotCalled
                              ? Center(
                                  child:
                                      Text('برای انتخاب محصول ابتدا سرچ کنید.'))
                              : _overlaySearchController.itemsStatus.status ==
                                      Status.Loading
                                  ? Center(child: DinawinIndicator())
                                  : _overlaySearchController
                                          .searchedParts.isEmpty
                                      ? Center(child: Text('کالایی یافت نشد.'))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: _overlaySearchController
                                              .searchedParts.length,
                                          itemBuilder: (ctx, i) => Column(
                                            children: [
                                              ChosenPartItem(
                                                  searchedPart:
                                                      _overlaySearchController
                                                          .searchedParts[i],
                                                  makeListModel: makeListModel),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        );
                        }),
                  ],
                ),
              ),
              SizedBox(height: 15),
              CustomDarkBtn(
                ontap: () {
                  if (makeListModel.details.isNotEmpty) {
                    // Get.back();

                    /// create new cart suggestion
                    Get.off(EditCheckAllSuggestion(
                      makeListModel: makeListModel,
                    ));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditCheckAllSuggestion(
                    //       makeListModel: makeListModel,
                    //     ),
                    //   ),
                    // );
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) => SelectPurchaseTypeModal(
                    //           makeListModel: makeListModel,
                    //         ));
                  } else {
                    Snacki()
                        .GETSnackBar(false, 'لطفا حداقل یک محصول انتخاب کنید.');
                  }
                },
                title: 'ثبت و برگشت',
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
