import 'package:e_shopweb/pages/product/widgets/components_cards_medium.dart';
import 'package:e_shopweb/pages/product/widgets/components_cards_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/controllers.dart';
import '../../helpers/my_provider.dart';
import '../../helpers/responsiveness.dart';
import '../../widgets/custom_text.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  late GlobalProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<GlobalProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6,
                          left: !ResponsiveWidget.isSmallScreen(context)
                              ? 35
                              : 0),
                      child: MyText(
                        text: menuControllere.activeItem.value,
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
            Expanded(
                child: (provider.isLoading)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          const ComponentsCardsMedium()
                          // if (ResponsiveWidget.isLargeScreen(context) ||
                          //     ResponsiveWidget.isMediumScreen(context))
                          //   if (ResponsiveWidget.isCustomScreen(context))
                          //     const ComponentsCardsMedium()
                          //   else
                          //     const ComponentsCardsMedium()
                          // else
                          //   const ComponentsCardSmall()
                        ],
                      )),
            const SizedBox(
              height: 65,
            ),
          ],
        );
      },
    );
  }
}
