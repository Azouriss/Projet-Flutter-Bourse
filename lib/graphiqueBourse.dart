import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GraphiqueBourse extends StatefulWidget {
  const GraphiqueBourse({Key? key}) : super(key: key);

  @override
  State<GraphiqueBourse> createState() => _GraphiqueBourseState();
}

class _GraphiqueBourseState extends State<GraphiqueBourse> {
  final List<FlSpot> spots = List.generate(60, (index) {
    // Génère des valeurs aléatoires entre 100 et 200 pour simuler des données boursières.
    double yValue = 100 + (Random().nextDouble() * 100);
    return FlSpot(index.toDouble(), yValue);
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: spots.last.x, // Utilisez la dernière valeur x comme maxX
        minY: 100, // Min y-value pour votre graphique
        maxY: 200, // Max y-value pour votre graphique
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blueAccent,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '\$${flSpot.y.toStringAsFixed(2)}',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
          touchCallback: (LineTouchResponse touchResponse) {},
          handleBuiltInTouches: true,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false, // Rendre la courbe moins lisse
            colors: [Colors.blue],
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
