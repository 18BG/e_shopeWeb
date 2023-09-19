import 'package:e_shopweb/constants/text_constant.dart';
import 'package:e_shopweb/fl_char/individual_bar.dart';

class BarData {
  final double sunAmount;

  final double monAmount;

  final double tueAmount;

  final double wedAmount;

  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  //initialize bar data
  void initializeBarData() {
    barData = [
      //sun
      IndividualBar(x: 0, y: sunAmount),
      //mon
      IndividualBar(x: 1, y: monAmount),
      //tue
      IndividualBar(x: 2, y: tueAmount),
      //wed
      IndividualBar(x: 3, y: wedAmount),
      //thur
      IndividualBar(x: 4, y: thurAmount),
      //fir
      IndividualBar(x: 5, y: friAmount),
      //sat
      IndividualBar(x: 6, y: satAmount)
    ];
  }
}
