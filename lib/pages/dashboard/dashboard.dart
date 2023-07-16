import 'package:e_shopweb/constants/controllers.dart';
import 'package:e_shopweb/helpers/responsiveness.dart';
import 'package:e_shopweb/pages/dashboard/widgets/dashboard_cards_medium.dart';
import 'package:e_shopweb/pages/dashboard/widgets/dashboard_topcards_large.dart';
import 'package:e_shopweb/pages/dashboard/widgets/dashboard_topcards_small.dart';
import 'package:e_shopweb/pages/dashboard/widgets/last_orders.dart';
import 'package:e_shopweb/pages/dashboard/widgets/statistics_section_large.dart';
import 'package:e_shopweb/pages/dashboard/widgets/statistics_section_small.dart';

import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/data_row_model.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final List<DataModele> data = [
    DataModele(
        id: 0,
        name: "Babry Galedou",
        mail: "bg@gmail.com",
        montant: 120430993,
        status: "Livré",
        date: "12/07/2023"),
    DataModele(
        id: 43,
        name: "Aymane DEMBELE",
        mail: "aymane@gmail.com",
        montant: 450,
        status: "En attente",
        date: "16/07/2023"),
    DataModele(
        id: 21,
        name: "Moussa",
        mail: "fma@gmail.com",
        montant: 2700,
        status: "Annulé",
        date: "14/04/2023")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: ResponsiveWidget.isCustomScreen(context) ? 56 : 6,
                  ),
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
            DataTableExample(myData: data)
          ],
        ))
      ],
    );
  }
}
