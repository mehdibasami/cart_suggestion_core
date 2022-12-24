library cart_suggestion_core;

export 'package:cart_suggestion_core/features/cart_suggestion/data/model/index.dart';
export 'package:cart_suggestion_core/features/cart_suggestion/domain/entity/index.dart';
export 'package:cart_suggestion_core/core/model/paging_model.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/bill_list_page.dart';
import 'package:flutter/material.dart';

class CartSuggestionCore extends StatelessWidget {
  const CartSuggestionCore({super.key});

  @override
  Widget build(BuildContext context) {
    return const BillListPage();
  }
}

setToken({String token = '', String creditToken = '',String customerToken=''}) {
  Constants.appToken = token;
  Constants.creditToken = creditToken;
  Constants.customerToken= customerToken;
  
}
