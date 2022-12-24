import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/utilities/custom_dialog.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_brand_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_vehicle_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/overlay_search_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/choose_product_screen.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/custom_dark_btn.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/custom_text_field.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/show_date_time_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/multi_select_drop_down.dart';

class MakeBillScreen extends StatefulWidget {
  MakeBillScreen({Key? key}) : super(key: key);

  @override
  State<MakeBillScreen> createState() => _MakeBillScreenState();
}

class _MakeBillScreenState extends State<MakeBillScreen> {
  final CartSuggestionItemParams makeListModel = CartSuggestionItemParams(
      id: null,
      title: '',
      imageUrl: '',
      isAllOrginal: false,
      isActive: false,
      startDate: null,
      endDate: null,
      vehicles: [],
      categories: [],
      brands: [],
      appNames: [],
      details: [],
      image: '');
  final OverlaySearchController overlaySearchController =
      Get.put(OverlaySearchController());

  List<int> selectedBrandIds = [];
  List<int> selectedCategoryIds = [];
  List<int> selectedVehicleIds = [];

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
    //*set initial data
    cartSuggestionController.selectedStartDate = DateTime.now();
    makeListModel.startDate = cartSuggestionController.selectedStartDate;
    cartSuggestionController.selectedEndDate = null;
    cartSuggestionController.selectedCategoryIds = [];
    cartSuggestionController.getCartSuggestionCategory();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (!_checkDataIsEmpty()) {
          _showWarningDialog(context);
          return Future.value(false);
        } else {
          if (Get.isRegistered<OverlaySearchController>()) {
            Get.delete<OverlaySearchController>();
          }
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: SecondAppBar(
          title: 'صورت گیری'.tr,
          onWillPop: () {
            if (!_checkDataIsEmpty()) {
              _showWarningDialog(context);
              return false;
            } else {
              if (Get.isRegistered<OverlaySearchController>()) {
                Get.delete<OverlaySearchController>();
              }
              return true;
            }
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 25),
                    CustomTextField(
                        onchange: (value) {
                          makeListModel.title = value;
                        },
                        title: 'نام گذاری لینک'.tr),

                    // *----- brands section
                    GetBuilder<CartSuggestionVehicleController>(
                      id: 'cartSuggestion_vehicle',
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MultiSelectDropDown(
                            customColor:
                                CBase().dinawinDarkGrey.withOpacity(0.1),
                            title: 'انتخاب خورو',
                            titleColor: CBase().dinawinDarkGrey,
                            icon: Icons.arrow_drop_down_rounded,
                            showSelected: true,
                            items: (vehicleController.vehicleModel?.values ??
                                    [])
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        e.vehicleName ?? 'بدون نام',
                                        style: CustomTypography.title12w500h15,
                                      ),
                                      value: e.vehicleId,
                                    ))
                                .toList(),
                            selected: selectedVehicleIds,
                            onSubmit: () {
                              makeListModel.vehicles = selectedVehicleIds;
                              print(selectedVehicleIds);
                            },
                            onSearch: (q) {
                              return vehicleController.search(q);
                            },
                          ),
                        );
                      },
                    ),

                    // CustomTextField(
                    //   onchange: (value) {
                    //     makeListModel.carName = value;
                    //   },
                    //   title: 'نام خودرو یا خودروها',
                    // ),
                    SizedBox(height: 12),
                    // *----- brands section
                    GetBuilder<CartSuggestionBrandController>(
                      id: 'cartSuggestion_brand',
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MultiSelectDropDown(
                            hight: 1.35,
                            customColor:
                                CBase().dinawinDarkGrey.withOpacity(0.1),
                            titleColor: CBase().dinawinDarkGrey,
                            icon: Icons.arrow_drop_down_rounded,
                            showSelected: true,
                            title: 'انتخاب برند',
                            items: (brandController.brandModel?.values ?? [])
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        e.brandName ?? 'بدون نام',
                                        style: CustomTypography.title12w500h15,
                                      ),
                                      value: e.brandId,
                                    ))
                                .toList(),
                            selected: selectedBrandIds,
                            onSubmit: () {
                              makeListModel.brands = selectedBrandIds;
                            },
                            onSearch: (q) {
                              return brandController.search(q);
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12),

                    Obx(() {
                      return cartSuggestionController
                              .cartSuggestionCategory.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: MultiSelectDropDown(
                                hight: 1.35,
                                customColor:
                                    CBase().dinawinDarkGrey.withOpacity(0.1),
                                titleColor: CBase().dinawinDarkGrey,
                                icon: Icons.arrow_drop_down_rounded,
                                showSelected: true,
                                title: 'انتخاب دسته ( Category )',
                                items: (cartSuggestionController
                                        .cartSuggestionCategory)
                                    .map((e) => DropdownMenuItem(
                                          child: Text(
                                            e.name,
                                            style:
                                                CustomTypography.title12w500h15,
                                          ),
                                          value: e.id,
                                        ))
                                    .toList(),
                                selected: cartSuggestionController
                                    .selectedCategoryIds,
                                onSubmit: () {
                                  debugPrint(
                                      'selectedCategoryIds: ${cartSuggestionController.selectedCategoryIds}');
                                  makeListModel.categories =
                                      cartSuggestionController
                                          .selectedCategoryIds;
                                },
                                // onSearch: (q) {
                                //   return brandController.search(q);
                                // },
                              ),
                            );
                    }),

                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      'تنظیم زمان آغاز و پایان دسترسی به لینک',
                      style: CustomTypography.title12w500h15,
                    ).marginSymmetric(horizontal: 30),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () async {
                        Jalali? pickedDate = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.fromDateTime(
                              cartSuggestionController.selectedStartDate),
                          firstDate: Jalali(1400, 8),
                          lastDate: Jalali(1550, 9),
                        );

                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showPersianTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                hour: cartSuggestionController
                                    .selectedStartDate.hour,
                                minute: cartSuggestionController
                                    .selectedStartDate.minute,
                              ));
                          DateTime newDate = pickedDate.toDateTime();
                          if (pickedTime != null) {
                            newDate = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          }
                          cartSuggestionController.selectedStartDate = newDate;
                          if (makeListModel.startDate != null) {
                            makeListModel.startDate =
                                cartSuggestionController.selectedStartDate;
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 93,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CBase().dinawinGrayBackground),
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoSwitch(
                                  activeColor: CBase().dinawinBrown02,
                                  value: makeListModel.startDate != null,
                                  onChanged: (value) {
                                    if (value) {
                                      makeListModel.startDate =
                                          cartSuggestionController
                                              .selectedStartDate;
                                    } else {
                                      makeListModel.startDate = null;
                                    }
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  'فعال کردن زمان آغاز دسترسی',
                                  style: CustomTypography.title16w500h20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 20,
                            child: ShowTimeAndDateWidget(
                                date:
                                    cartSuggestionController.selectedStartDate),
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    InkWell(
                      onTap: () async {
                        Jalali? pickedDate = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.fromDateTime(
                              cartSuggestionController.selectedStartDate
                                      .isAfter(cartSuggestionController
                                              .selectedEndDate ??
                                          DateTime.now())
                                  ? cartSuggestionController.selectedStartDate
                                  : (cartSuggestionController.selectedEndDate ??
                                      DateTime.now())),
                          firstDate: Jalali.fromDateTime(
                              cartSuggestionController.selectedStartDate),
                          lastDate: Jalali(1550, 9),
                        );

                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showPersianTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                hour: cartSuggestionController
                                        .selectedEndDate?.hour ??
                                    12,
                                minute: cartSuggestionController
                                        .selectedEndDate?.minute ??
                                    0,
                              ));
                          DateTime newDate = pickedDate.toDateTime();
                          if (pickedTime != null) {
                            newDate = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          }
                          cartSuggestionController.selectedEndDate = newDate;
                          if (makeListModel.endDate != null) {
                            makeListModel.endDate =
                                cartSuggestionController.selectedEndDate;
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 93,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CBase().dinawinGrayBackground),
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoSwitch(
                                  activeColor: CBase().dinawinBrown02,
                                  value: makeListModel.endDate != null,
                                  onChanged: (value) {
                                    if (value) {
                                      if (cartSuggestionController
                                              .selectedEndDate ==
                                          null) {
                                        Fluttertoast.showToast(
                                          gravity: ToastGravity.CENTER,
                                          msg:
                                              'ابتدا تاریخ مورد نظر را تنظیم کنید',
                                        );
                                      } else {
                                        Get.dialog(
                                          CustomDialog(
                                            title: 'زمان پایان لینک:',
                                            subTitle: ShowTimeAndDateWidget(
                                                date: cartSuggestionController
                                                    .selectedEndDate),
                                            alertText:
                                                'آیا مطمئن هستید که میخواهید زمان پایان لینک را فعال کنید؟',
                                            onTapYes: () {
                                              makeListModel.endDate =
                                                  cartSuggestionController
                                                      .selectedEndDate;
                                              Get.back();
                                              setState(() {});
                                            },
                                            onTapNo: () {
                                              makeListModel.endDate = null;
                                              Get.back();
                                              setState(() {});
                                            },
                                          ),
                                        );
                                      }
                                    } else {
                                      makeListModel.endDate = null;
                                      setState(() {});
                                    }
                                  },
                                ),
                                Text(
                                  'فعال کردن زمان پایان دسترسی',
                                  style: CustomTypography.title16w500h20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 20,
                            child: ShowTimeAndDateWidget(
                                date: cartSuggestionController.selectedEndDate),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              CustomDarkBtn(
                ontap: () {
                  // if (cartSuggestionController.selectedCategoryIds.isEmpty) {
                  //   Snacki().GETSnackBar(
                  //       false, 'لطفا دسته بندی مورد نظر را انتخاب کنید');
                  // } else {
                  if (makeListModel.title.isNotEmpty) {
                    Get.to(() => ChooseProductScreen(
                          makeListModel: makeListModel,
                        ));
                  } else {
                    Snacki()
                        .GETSnackBar(false, 'لطفا فیلد موضوع را وارد کنید.');
                  }
                  // }
                },
                title: 'انتخاب محصول'.tr,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  bool _checkDataIsEmpty() {
    if (makeListModel.title.isNotEmpty) {
      return false;
    }
    if (makeListModel.title.isNotEmpty) {
      return false;
    }
    if (makeListModel.vehicles.isNotEmpty) {
      return false;
    }
    if (makeListModel.details.isNotEmpty) {
      return false;
    }
    return true;
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('مطمئن هستید؟'),
            content:
                Text('با خروج از این صفحه اطلاعات وارد شده از دست میروند.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('خیر',
                      style: TextStyle(color: CBase().dinawinBrown))),
              TextButton(
                  onPressed: () {
                    if (Get.isRegistered<OverlaySearchController>()) {
                      Get.delete<OverlaySearchController>();
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'بله',
                    style: TextStyle(color: CBase().dinawinBrown),
                  )),
            ],
          );
        });
  }
}
