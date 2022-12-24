import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/part_with_detail_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/cart_suggestion_item.dart';
import 'package:flutter/material.dart';

class ChosenPartItem extends StatelessWidget {
  final PartWithDetailModel searchedPart;
  final CartSuggestionItemParams makeListModel;
  ChosenPartItem({
    Key? key,
    required this.searchedPart,
    required this.makeListModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    searchedPart.appName == null ||
                            searchedPart.appName!.isEmpty
                        ? "نام وارد نشده"
                        : searchedPart.appName!,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CBase().dinawinDarkGrey),
                  ),
                ),
              ),
              Text(
                searchedPart.vehiclePersianName == null ||
                        searchedPart.vehiclePersianName!.isEmpty
                    ? "نام وارد نشده"
                    : searchedPart.vehiclePersianName!,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CBase().dinawinDarkGrey),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: searchedPart.products!.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              CartSuggestionItem(
                detailModel:searchedPart.products![i]
                //  CartSuggestionDetailModel(
                //     brandImage: searchedPart.products![i].brandsImagePath,
                //     brandName: searchedPart.products![i].brandsName,
                //     bundle: searchedPart.products![i].bundle,
                //     bundlePrices: searchedPart.products![i].bundlePrices,
                //     cashPrice: searchedPart.products![i].cashPrice,
                //     country: searchedPart.products![i].country,
                //     creditPrice: searchedPart.products![i].creditPrice,
                //     fileType: searchedPart.products![i].fileType,
                //     id: searchedPart.products![i].productsId,
                //     productId: searchedPart.products![i].productsId,
                //     isGift: searchedPart.products![i].isGift,
                //     multipleQty: searchedPart.products![i].multipleQTY,
                //     limitations: searchedPart.products![i].limitations,
                //     showPriceApp: searchedPart.products![i].showPriceApp ?? 0,
                //     showTextApp: searchedPart.products![i].showTextApp,
                //     virtualQty: searchedPart.products![i].virtualQTY,
                //     physicalQty: searchedPart.products![i].physicalQTY ?? 0,
                //     paymentWay: searchedPart.products![i].paymentWay,
                //     productImage: (searchedPart.products![i].images != null &&
                //             searchedPart.products![i].images!.isNotEmpty)
                //         ? searchedPart.products![i].images!.first
                //         : '',
                //     productName: searchedPart.products![i].productsName)
                    ,

                makeListModel: makeListModel,
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // void _checkList() {
  //   makeListModel.details = [];
  // }
}
