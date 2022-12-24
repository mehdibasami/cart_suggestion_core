import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_brand_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'multi_select_drop_down.dart';

class BillsFilterSection extends StatefulWidget {
  const BillsFilterSection({Key? key}) : super(key: key);

  @override
  State<BillsFilterSection> createState() => _BillsFilterSectionState();
}

class _BillsFilterSectionState extends State<BillsFilterSection> {
  List<int> selectedIds = [];

  // *controllers
  CartSuggestionController cartSuggestionController =
      Get.put(CartSuggestionController());
  CartSuggestionBrandController brandController =
      Get.put(CartSuggestionBrandController());
  CartSuggestionVehicleController vehicleController =
      Get.put(CartSuggestionVehicleController());

  @override
  void initState() {
    super.initState();
    brandController.getSuggestedBrands();
    vehicleController.getSuggestedVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          // *----- brands section
          GetBuilder<CartSuggestionVehicleController>(
            id: 'cartSuggestion_vehicle',
            builder: (_) {
              return Expanded(
                child: MultiSelectDropDown(
                  title: 'خودرو',
                  items: (vehicleController.vehicleModel?.values ?? [])
                      .map((e) => DropdownMenuItem(
                            child: Text(e.vehicleName ?? 'بدون نام'),
                            value: e.vehicleId,
                          ))
                      .toList(),
                  selected: selectedIds,
                  onSubmit: () {
                    cartSuggestionController.filterVehicle(selectedIds);
                    print(selectedIds);
                  },
                  onSearch: (q) {
                    return vehicleController.search(q);
                  },
                ),
              );
            },
          ),
          SizedBox(width: 10),

          // *----- brands section
          GetBuilder<CartSuggestionBrandController>(
            id: 'cartSuggestion_brand',
            builder: (_) {
              return Expanded(
                child: MultiSelectDropDown(
                  title: 'برند',
                  items: (brandController.brandModel?.values ?? [])
                      .map((e) => DropdownMenuItem(
                            child: Text(
                              e.brandName ?? 'بدون نام',
                            ),
                            value: e.brandId,
                          ))
                      .toList(),
                  selected: selectedIds,
                  onSubmit: () {
                    cartSuggestionController.filterBrand(selectedIds);
                    print(selectedIds);
                  },
                  onSearch: (q) {
                    return brandController.search(q);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
