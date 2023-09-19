import 'package:e_shopweb/fl_char/bar_graph.dart';
import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/model/vente_model.dart';
import 'package:e_shopweb/pages/dashboard/widgets/revenue_info.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';

class StatisticsSectionLarge extends StatelessWidget {
  const StatisticsSectionLarge({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> weeklySummary = [5.5, 10.3, 56.7, 79, 100, 78, 230, 5];
    return Consumer<GlobalProvider>(
      builder: (context, value, child) {
        List<VenteModel> vente = value.venteModel;

        return Container(
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              border: Border.all(color: lightGrey, width: .5)),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const MyText(
                      text: "Revenue Chart",
                      size: 20,
                      color: lightGrey,
                      weight: FontWeight.bold),
                  // SizedBox(
                  //   width: 600,
                  //   height: 200,
                  //   child: SimpleBarChart.withSampleData(),
                  // )

                  SizedBox(
                      width: 800,
                      height: 250,
                      child: MyBarGraph(
                        liste: value.salesSummary,
                      )),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )),
              Container(
                width: 1,
                height: 120,
                color: lightGrey,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      RevenuInfo(
                          title: "Today's revenue",
                          amount: value.today_income.toString()),
                      RevenuInfo(
                          title: "Last 7 days",
                          amount: value.last_week.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      RevenuInfo(
                          title: "Last 30 days",
                          amount: value.last_thirty.toString()),
                      RevenuInfo(
                          title: "Last 12 months",
                          amount: value.last_twelve.toString()),
                    ],
                  ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
