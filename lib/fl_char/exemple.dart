import 'package:e_shopweb/model/vente_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesChart extends StatelessWidget {
  final List<VenteModel> salesData;

  SalesChart({required this.salesData});

  @override
  Widget build(BuildContext context) {
    // Créez une liste de ventes par date avec le montant total pour chaque date.
    Map<DateTime, double> salesByDate = {};

    for (var vente in salesData) {
      DateTime date = vente.dateVente;
      // double price = vente.price;

      // Si la date existe déjà dans la liste, ajoutez le montant à la vente existante.
      if (salesByDate.containsKey(date)) {
        //salesByDate[date] += 10;
      } else {
        // Sinon, créez une nouvelle entrée pour cette date.
        // salesByDate[date] = price;
      }
    }

    // Triez les ventes par date.
    List<MapEntry<DateTime, double>> sortedSales = salesByDate.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    // Créez une liste de données pour le graphique.
    List<BarChartGroupData> chartData = [];

    for (var entry in sortedSales) {
      chartData.add(
        BarChartGroupData(
          x: entry.key.day
              .toInt(), // Utilisez le jour comme x pour le graphique.
          barRods: [
            BarChartRodData(
              toY: entry.value,
              color: Colors.blue, // Couleur des barres.
            ),
          ],
        ),
      );
    }

    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            )),
        borderData: FlBorderData(
          show: true,
        ),
        gridData: FlGridData(
          show: true,
        ),
        barGroups: chartData,
      ),
    );
  }
}
