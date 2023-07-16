import 'package:e_shopweb/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: DashBoard()),
      ],
    );
  }
}
