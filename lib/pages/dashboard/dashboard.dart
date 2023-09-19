import 'package:e_shopweb/constants/controllers.dart';
import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/pages/dashboard/widgets/dashboard_cards_medium.dart';
import 'package:e_shopweb/pages/dashboard/widgets/dashboard_topcards_large.dart';
import 'package:e_shopweb/pages/dashboard/widgets/dashboard_topcards_small.dart';

import 'package:e_shopweb/pages/dashboard/widgets/statistics_section_large.dart';
import 'package:e_shopweb/pages/dashboard/widgets/statistics_section_small.dart';

import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6,
                      left: !ResponsiveWidget.isSmallScreen(context) ? 35 : 0),
                  child: MyText(
                    text: menuControllere.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                )
              ],
            )),
        Expanded(
            child: ListView(
          shrinkWrap: false,
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomScreen(context))
                const DashBoardCardsMediumScreenSize()
              else
                const DashBoardTopCardsLargeScreen()
            else
              const DashBoardTopCardsSmallScreen(),
            if (ResponsiveWidget.isSmallScreen(context))
              const StatisticsSectionSmall()
            else
              const StatisticsSectionLarge(),
            //MyDataTable(myData: data),
            // AvailableDrivers(
            //   myData: data,
            // )
          ],
        ))
      ],
    );
  }
}
