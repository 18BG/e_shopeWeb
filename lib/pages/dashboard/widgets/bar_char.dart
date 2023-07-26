/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final List<Series<dynamic, String>> seriesListe;
  final bool animate;

  const SimpleBarChart(this.seriesListe, this.seriesList,
      {super.key, required this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return SimpleBarChart(
      _createSampleData(),
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesListe,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('Today', 4560),
      OrdinalSales('Yesterday', 1785),
      OrdinalSales('2 days', 1100),
      OrdinalSales('15 Jul', 2175),
      OrdinalSales('16 Jul', 2175),
      OrdinalSales('17 Jul', 1275),
      OrdinalSales('18 Jul', 1200),
      OrdinalSales('19 Jul', 5908),
      OrdinalSales('20 Jul', 5000),
      OrdinalSales('21 Jul', 576),
      OrdinalSales('22 Jul', 4500),
      OrdinalSales('23 Jul', 3560),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
