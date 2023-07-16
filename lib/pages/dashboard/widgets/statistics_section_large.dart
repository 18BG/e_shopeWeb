import 'package:e_shopweb/pages/dashboard/widgets/revenue_info.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import 'bar_char.dart';

class StatisticsSectionLarge extends StatelessWidget {
  const StatisticsSectionLarge({super.key});

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                width: 600,
                height: 200,
                child: SimpleBarChart.withSampleData(),
              )
            ],
          )),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          const Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  RevenuInfo(title: "Today\'s revenue", amount: "23"),
                  RevenuInfo(title: "Last 7 days", amount: "150"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  RevenuInfo(title: "Last 30 days", amount: "1,203"),
                  RevenuInfo(title: "Last 12 months", amount: "3,234"),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
