import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/overlay_search_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/chosen_part_item.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/custom_dark_btn.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/search_widget_with_overlay.dart';
import 'check_all_suggestions.dart';

class ChooseProductScreen extends StatefulWidget {
  final CartSuggestionItemParams makeListModel;

  ChooseProductScreen({
    Key? key,
    required this.makeListModel,
  }) : super(key: key);

  @override
  State<ChooseProductScreen> createState() => _ChooseProductScreenState();
}

class _ChooseProductScreenState extends State<ChooseProductScreen> {
  final OverlaySearchController _overlaySearchController =
      Get.put(OverlaySearchController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // makeListModel.chosenProduct = [];
        return Future.value(true);
      },
      child: Scaffold(
        appBar: SecondAppBar(
          title: 'انتخاب محصول'.tr,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      SearchWidgetWithOverlay(
                        vehicleIds: widget.makeListModel.vehicles,
                        brandIds: widget.makeListModel.brands,
                        searchCallBack: ((searchText) {}),
                      ),
                      SizedBox(height: 15),
                      GetBuilder<OverlaySearchController>(
                          id: 'items',
                          builder: (logic) {
                            return _overlaySearchController
                                        .itemsStatus.status ==
                                    Status.NotCalled
                                ? Center(
                                    child: Text(
                                        'برای انتخاب محصول ابتدا سرچ کنید.'))
                                : _overlaySearchController.itemsStatus.status ==
                                        Status.Loading
                                    ? Center(child: DinawinIndicator())
                                    : _overlaySearchController
                                            .searchedParts.isEmpty
                                        ? Center(
                                            child: Text('کالایی یافت نشد.'))
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
                                                    makeListModel:
                                                        widget.makeListModel),
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
                    if (widget.makeListModel.details.isNotEmpty) {
                      /// create new cart suggestion
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckAllSuggestion(
                            makeListModel: widget.makeListModel,
                          ),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: (context) => SelectPurchaseTypeModal(
                      //           makeListModel: makeListModel,
                      //         ));
                    } else {
                      Snacki().GETSnackBar(
                          false, 'لطفا حداقل یک محصول انتخاب کنید.');
                    }
                  },
                  title: 'ادامه',
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
