import 'package:e_shopweb/helpers/my_provider.dart';

import 'package:e_shopweb/pages/product/product_management/add_product_medium.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late GlobalProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AddProductMedium(
      provider: provider,
    );
  }
}
  //  if (ResponsiveWidget.isSmallScreen(context))
  //     return AddProductSmall(
  //       provider: provider,
  //     );
  //   else if (ResponsiveWidget.isMediumScreen(context))
  //     return AddProductMedium(
  //       provider: provider,
  //     );
  //   else
  //     return AddProductLarge(
  //       provider: provider,
  //     );