import 'package:cart_suggestion_core/core/widgets/custom_network_image.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';

import 'package:flutter/material.dart';

class ShowImageFullSize extends StatelessWidget {
  final String imageUrl;
  const ShowImageFullSize({
    Key? key,
    this.imageUrl = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppBar(title: ''),
      body: Center(
        child: CustomNetworkImage(imageUrl: imageUrl),
      ),
    );
  }
}
