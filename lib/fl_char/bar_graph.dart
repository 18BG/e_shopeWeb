import 'package:e_shopweb/fl_char/bar_data.dart';
import 'package:e_shopweb/model/vente_model.dart';
import 'package:e_shopweb/widgets/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatefulWidget {
  final List<Map<String, dynamic>> liste;
  const MyBarGraph({required this.liste, super.key});

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  Widget build(BuildContext context) {
    // BarData myBarData = BarData(
    //     sunAmount: widget.weklySummary[0],
    //     monAmount: widget.weklySummary[1],
    //     tueAmount: widget.weklySummary[2],
    //     wedAmount: widget.weklySummary[3],
    //     thurAmount: widget.weklySummary[4],
    //     friAmount: widget.weklySummary[5],
    //     satAmount: widget.weklySummary[6]);
    // myBarData.initializeBarData();
    return graph();
  }

  double getMaxTotalVentes(List<Map<String, dynamic>> ventes) {
    double maxTotalVentes = 0;
    for (var vente in ventes) {
      if (vente['totalVentes'] > maxTotalVentes) {
        maxTotalVentes = vente['totalVentes'];
      }
    }
    return maxTotalVentes + 10;
  }

  List<BarChartGroupData> createBarGroups(List<Map<String, dynamic>> ventes) {
    List<BarChartGroupData> barGroups = [];
    for (var vente in ventes) {
      barGroups.add(
        BarChartGroupData(
          x: ventes.indexOf(vente),
          barRods: [
            BarChartRodData(
                toY: vente['totalVentes'],
                color: Colors.blue,
                width: 25,
                borderRadius: BorderRadius.circular(10),
                backDrawRodData: BackgroundBarChartRodData(
                    show: true, toY: 100, color: Colors.grey[200])),
          ],
          //showingTooltipIndicators: [0],
        ),
      );
    }
    return barGroups;
  }

  BarChart graph() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        maxY: getMaxTotalVentes(widget.liste),
        minY: 0,
        titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 50,
                showTitles: true,
                getTitlesWidget: (context, value) {
                  // Renvoie le titre (la date) correspondant à la valeur
                  int index = context.toInt();
                  if (index >= 0 && index < widget.liste.length) {
                    String date = widget.liste[index]['date'];
                    List<String> dateParts =
                        date.split('/'); // Divisez la date en trois parties

                    String day = dateParts[0]; // Obtenez le jour
                    String month = dateParts[1]; // Obtenez le mois
                    String year = dateParts[2]; // Obtenez l'année
                    Widget toShow = Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Pour centrer le texte
                      children: <Widget>[
                        Text(
                          day, // Jour
                          style: TextStyle(
                            fontSize: 10, // Taille de la police pour le jour
                          ),
                        ),
                        Text(
                          month, // Mois
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          year, // Année
                          style: TextStyle(
                            fontSize: 10, // Taille de la police pour l'année
                          ),
                        ),
                      ],
                    );
                    print(widget.liste[index]['date']);
                    return SideTitleWidget(
                        axisSide: value.axisSide, child: toShow);
                  }
                  return SideTitleWidget(
                      child: Text(""), axisSide: value.axisSide);
                },
              ),
            )),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(show: false),
        barGroups: createBarGroups(widget.liste),
      ),
    );
  }

  //Premiere etat du graphe
  // BarChart firstChart() {
  //   return BarChart(
  //     BarChartData(
  //         titlesData: const FlTitlesData(
  //             show: true,
  //             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //             rightTitles:
  //                 AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //             bottomTitles: AxisTitles(
  //                 sideTitles: SideTitles(
  //                     showTitles: true, getTitlesWidget: getBottomTitles))),
  //         borderData: FlBorderData(show: false),
  //         gridData: FlGridData(show: false),
  //         maxY: 100,
  //         minY: 0,
  //         barGroups: myBarData.barData
  //             .map((data) => BarChartGroupData(x: data.x, barRods: [
  //                   BarChartRodData(
  //                       toY: data.y,
  //                       color: Colors.grey,
  //                       width: 15,
  //                       borderRadius: BorderRadius.circular(15),
  //                       backDrawRodData: BackgroundBarChartRodData(
  //                           show: true, toY: 100, color: Colors.grey[200]))
  //                 ]))
  //             .toList()),
  //   );
  // }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text("S", style: style);
      break;
    case 1:
      text = const Text("M", style: style);
      break;
    case 2:
      text = const Text("T", style: style);
      break;
    case 3:
      text = const Text("W", style: style);
      break;
    case 4:
      text = const Text("T", style: style);
      break;
    case 5:
      text = const Text("F", style: style);
      break;
    case 6:
      text = const Text("S", style: style);
      break;
    default:
      text = const Text("", style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
