import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/make_bill_screen.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/bill_item.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/bills_filter_section.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';
import 'package:flutter/material.dart';
// import 'package:copapp/View/Pages/cart_suggestion/widget/filter_item.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../widget/search_widget.dart';

class BillListPage extends StatefulWidget {
  const BillListPage({Key? key}) : super(key: key);

  @override
  State<BillListPage> createState() => _BillListPageState();
}

class _BillListPageState extends State<BillListPage> {
  @override
  initState() {
    super.initState();
    cartSuggestionController.getCartSuggestionCategory();
    cartSuggestionController.cartSuggestionPagingController
        .addPageRequestListener((pageKey) {
      cartSuggestionController.getSuggestion(pageKey: pageKey);
    });
    // cartSuggestionController.cartSuggestionPagingController
    //     .addStatusListener((status) {
    //   cartSuggestionController.update(['cartS']);
    // });
  }

  //*----- controllers
  TextEditingController controller = TextEditingController();
  CartSuggestionController cartSuggestionController =
      Get.put(CartSuggestionController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.isRegistered<CartSuggestionController>()) {
          Get.delete<CartSuggestionController>();
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: CBase().dinawinBackGround,
        appBar: SecondAppBar(title: 'بانک لینک های صورت گیری'),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    //*----- search box
                    SearchWidget(
                      controller: controller,
                      onSearch: ((q) {
                        cartSuggestionController.search(q);
                      }),
                    ),
                    SizedBox(height: 20),

                    // *----- filter
                    BillsFilterSection(),
                    SizedBox(height: 20),

                    //*----- bills list
                    Expanded(
                      child: GetBuilder<CartSuggestionController>(
                          id: 'cartS',
                          builder: (_) {
                            return cartSuggestionController
                                        .deleteStatus.status ==
                                    Status.Error
                                ? Column(
                                    children: [
                                      Text('خطا'),
                                      InkWell(
                                          onTap: cartSuggestionController
                                              .onTapTryAgain,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('تلاش مجدد'),
                                          )),
                                    ],
                                  )
                                : PagedListView<int, CartSuggestionItemEntity>(
                                    shrinkWrap: true,
                                    pagingController: cartSuggestionController
                                        .cartSuggestionPagingController,
                                    builderDelegate: PagedChildBuilderDelegate<
                                        CartSuggestionItemEntity>(
                                      itemBuilder: (context, item, index) =>
                                          Column(
                                        children: [
                                          BillItems(
                                            model: item,
                                            onDelete: (id) {
                                              cartSuggestionController
                                                  .deleteCartSuggestion(id);
                                            },
                                            enable: (id) =>
                                                cartSuggestionController
                                                    .enableCartSuggestion(id),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );

                            // ListView.builder(
                            //     shrinkWrap: true,
                            //     physics: ClampingScrollPhysics(),
                            //     itemCount: cartSuggestionController
                            //         .cartSuggestionItems.length,
                            //     itemBuilder: (ctx, i) => Column(
                            //       children: [
                            //         BillItems(
                            //           model: cartSuggestionController
                            //               .cartSuggestionItems[i],
                            //           onDelete: (id) {
                            //             cartSuggestionController
                            //                 .removeCartSuggestion(id);
                            //           },
                            //         ),
                            //         SizedBox(height: 10),
                            //       ],
                            //     ),
                            //   );
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
                child: Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Get.to(() => MakeBillScreen());
                      },
                      backgroundColor: CBase().dinawinBrown,
                      child: Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: CBase().dinawinWhite,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('ایجاد لینک')
                  ],
                ),
              ),
            ],
          ),
        ),

        // *----- floating action btn
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: Row(
        //   children: [
        //     FloatingActionButton(
        //       onPressed: () {
        //         Get.to(() => MakeBillScreen());
        //       },
        //       backgroundColor: CBase().dinawinDarkGrey,
        //       child: Center(
        //         child: Icon(
        //           Icons.add_rounded,
        //           color: CBase().dinawinWhite,
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       width: 8,
        //     ),
        //     Text('افزودن لینک')
        //   ],
        // ),
      ),
    );
  }
}
