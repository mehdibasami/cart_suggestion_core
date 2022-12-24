import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/utilities/custom_dialog.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_brand_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_vehicle_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/edit/edit_suggestion_title_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/show_date_time_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../widget/custom_dark_btn.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/multi_select_drop_down.dart';
import '../../widget/second_app_bar.dart';

class EditSuggestionTitlePage extends StatefulWidget {
  EditSuggestionTitlePage({Key? key, required this.cartSuggestionId})
      : super(key: key);
  final int cartSuggestionId;

  @override
  State<EditSuggestionTitlePage> createState() =>
      _EditSuggestionTitlePageState();
}

class _EditSuggestionTitlePageState extends State<EditSuggestionTitlePage> {
  @override
  void initState() {
    super.initState();
    ctrl
        .getCartSuggestionById(cartSuggestionId: widget.cartSuggestionId)
        .then((value) {
      cartSuggestionController.getCartSuggestionCategory();
      ctrl.makeListModel.brands = [];
      ctrl.makeListModel.vehicles = [];
      ctrl.selectedCategoryIds = ctrl.makeListModel.categories;
      ctrl.selectedStartDate = ctrl.makeListModel.startDate ?? DateTime.now();
      ctrl.selectedEndDate = ctrl.makeListModel.endDate;
    });
  }

  final EditCartSuggestionController ctrl =
      Get.put(EditCartSuggestionController());

  final CartSuggestionController cartSuggestionController = Get.find();

  final CartSuggestionVehicleController vehicleController =
      Get.put(CartSuggestionVehicleController());

  final CartSuggestionBrandController brandController =
      Get.put(CartSuggestionBrandController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // return true;
        _showWarningDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: SecondAppBar(
          title: 'ادیت لیست صورت گیری'.tr,
          // onWillPop: () {
          //   // if (!_checkDataIsEmpty()) {
          //   //   _showWarningDialog(context);
          //   //   return false;
          //   // } else {
          //   //   return true;
          //   // }
          // },
        ),
        body: GetBuilder<EditCartSuggestionController>(
            id: 'cart',
            builder: (_) {
              return SafeArea(
                child: ctrl.getStatus.status == Status.Loading
                    ? Center(child: DinawinIndicator())
                    : Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                SizedBox(height: 25),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: CustomTextField(
                                    controller: ctrl.txtCtrl,
                                    onchange: (value) {
                                      ctrl.makeListModel.title = value;
                                    },
                                    title: 'موضوع',
                                  ),
                                ),

                                // *----- brands section
                                GetBuilder<EditCartSuggestionController>(
                                  id: 'cartSuggestion_vehicle',
                                  builder: (_) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: MultiSelectDropDown(
                                        customColor: CBase()
                                            .dinawinDarkGrey
                                            .withOpacity(0.1),
                                        title: 'خودرو',
                                        titleColor: CBase().dinawinDarkGrey,
                                        icon: Icons.arrow_drop_down_rounded,
                                        showSelected: true,
                                        items: (vehicleController
                                                    .vehicleModel?.values ??
                                                [])
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                    e.vehicleName ?? 'بدون نام',
                                                    style: TextStyle(
                                                      color: CBase()
                                                          .dinawinDarkGrey,
                                                    ),
                                                  ),
                                                  value: e.vehicleId,
                                                ))
                                            .toList(),
                                        selected: ctrl.selectedVehicleIds,
                                        onSubmit: () {
                                          // ctrl.makeListModel.vehicles =
                                          //     ctrl.selectedVehicleIds;
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: MultiSelectDropDown(
                                        customColor: CBase()
                                            .dinawinDarkGrey
                                            .withOpacity(0.1),
                                        titleColor: CBase().dinawinDarkGrey,
                                        icon: Icons.arrow_drop_down_rounded,
                                        showSelected: true,
                                        title: 'برند',
                                        items: (brandController
                                                    .brandModel?.values ??
                                                [])
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(
                                                    e.brandName ?? 'بدون نام',
                                                    style: TextStyle(
                                                      color: CBase()
                                                          .dinawinDarkGrey,
                                                    ),
                                                  ),
                                                  value: e.brandId,
                                                ))
                                            .toList(),
                                        selected: ctrl.selectedBrandIds,
                                        onSubmit: () {
                                          // ctrl.makeListModel.brands =
                                          //     ctrl.selectedBrandIds;
                                        },
                                        onSearch: (q) {
                                          return brandController.search(q);
                                        },
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),

                                Obx(() {
                                  return cartSuggestionController
                                          .cartSuggestionCategory.isEmpty
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: MultiSelectDropDown(
                                            hight: 1.35,
                                            customColor: CBase()
                                                .dinawinDarkGrey
                                                .withOpacity(0.1),
                                            titleColor: CBase().dinawinDarkGrey,
                                            icon: Icons.arrow_drop_down_rounded,
                                            showSelected: true,
                                            title: 'انتخاب دسته ( Category )',
                                            items: (cartSuggestionController
                                                    .cartSuggestionCategory)
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(
                                                        e.name,
                                                        style: CustomTypography
                                                            .title12w500h15,
                                                      ),
                                                      value: e.id,
                                                    ))
                                                .toList(),
                                            selected: ctrl.selectedCategoryIds,
                                            onSubmit: () {
                                              debugPrint(
                                                  'selectedCategoryIds: ${ctrl.selectedCategoryIds}');
                                              ctrl.makeListModel.categories =
                                                  ctrl.selectedCategoryIds;
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
                                    Jalali? pickedDate =
                                        await showPersianDatePicker(
                                      context: context,
                                      initialDate: Jalali.fromDateTime(
                                          ctrl.selectedStartDate),
                                      firstDate: Jalali(1400, 8),
                                      lastDate: Jalali(1550, 9),
                                    );

                                    if (pickedDate != null) {
                                      TimeOfDay? pickedTime =
                                          await showPersianTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                hour:
                                                    ctrl.selectedStartDate.hour,
                                                minute: ctrl
                                                    .selectedStartDate.minute,
                                              ));
                                      DateTime newDate =
                                          pickedDate.toDateTime();
                                      if (pickedTime != null) {
                                        newDate = DateTime(
                                          newDate.year,
                                          newDate.month,
                                          newDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );
                                      }
                                      ctrl.selectedStartDate = newDate;
                                      if (ctrl.makeListModel.startDate !=
                                          null) {
                                        ctrl.makeListModel.startDate =
                                            ctrl.selectedStartDate;
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    height: 93,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: CBase().dinawinGrayBackground),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CupertinoSwitch(
                                              activeColor:
                                                  CBase().dinawinBrown02,
                                              value: ctrl.makeListModel
                                                      .startDate !=
                                                  null,
                                              onChanged: (value) {
                                                if (value) {
                                                  ctrl.makeListModel.startDate =
                                                      ctrl.selectedStartDate;
                                                } else {
                                                  ctrl.makeListModel.startDate =
                                                      null;
                                                }
                                                setState(() {});
                                              },
                                            ),
                                            Text(
                                              'فعال کردن زمان آغاز دسترسی',
                                              style: CustomTypography
                                                  .title16w500h20,
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
                                            date: ctrl.selectedStartDate),
                                      ),
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                InkWell(
                                  onTap: () async {
                                    Jalali? pickedDate =
                                        await showPersianDatePicker(
                                      context: context,
                                      initialDate: Jalali.fromDateTime(ctrl
                                              .selectedStartDate
                                              .isAfter(ctrl.selectedEndDate ??
                                                  DateTime.now())
                                          ? ctrl.selectedStartDate
                                          : (ctrl.selectedEndDate ??
                                              DateTime.now())),
                                      firstDate: Jalali.fromDateTime(
                                          ctrl.selectedStartDate),
                                      lastDate: Jalali(1550, 9),
                                    );

                                    if (pickedDate != null) {
                                      TimeOfDay? pickedTime =
                                          await showPersianTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay(
                                                hour: ctrl.selectedEndDate
                                                        ?.hour ??
                                                    12,
                                                minute: ctrl.selectedEndDate
                                                        ?.minute ??
                                                    0,
                                              ));
                                      DateTime newDate =
                                          pickedDate.toDateTime();
                                      if (pickedTime != null) {
                                        newDate = DateTime(
                                          newDate.year,
                                          newDate.month,
                                          newDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );
                                      }
                                      ctrl.selectedEndDate = newDate;
                                      if (ctrl.makeListModel.endDate != null) {
                                        ctrl.makeListModel.endDate =
                                            ctrl.selectedEndDate;
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    height: 93,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: CBase().dinawinGrayBackground),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CupertinoSwitch(
                                              activeColor:
                                                  CBase().dinawinBrown02,
                                              value:
                                                  ctrl.makeListModel.endDate !=
                                                      null,
                                              onChanged: (value) {
                                                if (value) {
                                                  if (ctrl.selectedEndDate ==
                                                      null) {
                                                    Fluttertoast.showToast(
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      msg:
                                                          'ابتدا تاریخ مورد نظر را تنظیم کنید',
                                                    );
                                                  } else {
                                                    Get.dialog(
                                                      CustomDialog(
                                                        title:
                                                            'زمان پایان لینک:',
                                                        subTitle:
                                                            ShowTimeAndDateWidget(
                                                                date: ctrl
                                                                    .selectedEndDate),
                                                        alertText:
                                                            'آیا مطمئن هستید که میخواهید زمان پایان لینک را فعال کنید؟',
                                                        onTapYes: () {
                                                          ctrl.makeListModel
                                                                  .endDate =
                                                              ctrl.selectedEndDate;
                                                          Get.back();
                                                          setState(() {});
                                                        },
                                                        onTapNo: () {
                                                          ctrl.makeListModel
                                                              .endDate = null;
                                                          Get.back();
                                                          setState(() {});
                                                        },
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  ctrl.makeListModel.endDate =
                                                      null;
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                            Text(
                                              'فعال کردن زمان پایان دسترسی',
                                              style: CustomTypography
                                                  .title16w500h20,
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
                                            date: ctrl.selectedEndDate),
                                      ),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          CustomDarkBtn(
                            ontap: ctrl.onTapEditProductBtn,
                            title: 'ویرایش محصول'.tr,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
              );
            }),
      ),
    );
  }

  // bool _checkDataIsEmpty() {
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
                    ctrl.makeListModel = CartSuggestionItemParams(
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('بله',
                      style: TextStyle(color: CBase().dinawinBrown))),
            ],
          );
        });
  }
}
