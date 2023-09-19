import 'package:e_shopweb/fl_char/bar_graph.dart';
import 'package:e_shopweb/helpers/my_provider.dart';
import 'package:e_shopweb/pages/dashboard/widgets/revenue_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import 'bar_char.dart';

class StatisticsSectionSmall extends StatelessWidget {
  const StatisticsSectionSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 6),
                    color: lightGrey.withOpacity(.1),
                    blurRadius: 12)
              ],
              border: Border.all(color: lightGrey, width: .5)),
          child: Column(
            children: [
              Container(
                height: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const MyText(
                        text: "Revenue Chart",
                        size: 20,
                        color: lightGrey,
                        weight: FontWeight.bold),
                    SizedBox(
                        width: 600,
                        height: 200,
                        child: MyBarGraph(liste: value.salesSummary))
                  ],
                ),
              ),
              Container(
                width: 120,
                height: 1,
                color: lightGrey,
              ),
              SizedBox(
                height: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        RevenuInfo(
                            title: "Today\'s revenue",
                            amount: value.today_income.toString()),
                        RevenuInfo(
                            title: "Last 7 days",
                            amount: value.last_week.toString()),
                      ],
                    ),
                    SizedBox(
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
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
