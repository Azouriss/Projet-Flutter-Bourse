import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GraphiqueBourse extends StatefulWidget {
  const GraphiqueBourse({Key? key}) : super(key: key);

  @override
  State<GraphiqueBourse> createState() => _GraphiqueBourseState();
}

class _GraphiqueBourseState extends State<GraphiqueBourse> {
  // Création d'une liste de spots (points) pour le graphique, avec des valeurs aléatoires pour simuler des données boursières.
  final List<FlSpot> spots = List.generate(60, (index) {
    // Génère un point avec l'index comme valeur x et une valeur y aléatoire entre 100 et 200.
    double yValue = 100 + (Random().nextDouble() * 100);
    return FlSpot(index.toDouble(), yValue);
  });

  @override
  Widget build(BuildContext context) {
    // Création et configuration du graphique linéaire.
    return LineChart(
      LineChartData(
        gridData: FlGridData(
            show:
                false), // Désactivation de la grille de fond pour un aspect plus épuré.
        titlesData:
            FlTitlesData(show: false), // Désactivation des titres sur les axes.
        borderData: FlBorderData(
            show: false), // Désactivation des bordures du graphique.
        minX: 0, // Définition de la valeur minimale sur l'axe X.
        maxX: spots.last
            .x, // Utilisation de la dernière valeur x des points générés comme valeur maximale sur l'axe X.
        minY: 100, // Définition de la valeur minimale sur l'axe Y.
        maxY: 200, // Définition de la valeur maximale sur l'axe Y.
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor:
                Colors.blueAccent, // Couleur de fond des infobulles au toucher.
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              // Configuration des éléments d'infobulle pour afficher la valeur y du point touché.
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '\$${flSpot.y.toStringAsFixed(2)}', // Formatage de la valeur y avec deux décimales.
                  const TextStyle(
                      color: Colors.white), // Style du texte de l'infobulle.
                );
              }).toList();
            },
          ),
          touchCallback: (LineTouchResponse touchResponse) {},
          handleBuiltInTouches:
              true, // Activation du traitement intégré des touchers.
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots, // Utilisation des points générés aléatoirement.
            isCurved:
                false, // Option pour ne pas arrondir les angles entre les points.
            colors: [Colors.blue], // Couleur de la ligne du graphique.
            barWidth: 2, // Largeur de la ligne du graphique.
            isStrokeCapRound:
                true, // Arrondissement des extrémités de la ligne.
            dotData: FlDotData(
                show:
                    false), // Désactivation de l'affichage des points sur le graphique.
            belowBarData: BarAreaData(
                show:
                    false), // Désactivation de la coloration en dessous de la ligne du graphique.
          ),
        ],
      ),
    );
  }
}
