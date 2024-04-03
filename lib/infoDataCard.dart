import 'package:flutter/material.dart';
import 'dart:convert';

import './graphiqueBourse.dart';
import './DetailPage.dart';

import 'package:fl_chart/fl_chart.dart';

class InfoDataGraphique extends StatelessWidget {
  final String data;

  const InfoDataGraphique({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Décodage de la chaîne de données JSON en une map pour un traitement plus facile.
    final Map<String, dynamic> stockData = json.decode(data)[0];

    // Détermination de la tendance du marché (haussière ou baissière) en fonction du changement de valeur.
    final bool isUp = stockData['change'] >= 0;
    final IconData iconData = isUp ? Icons.trending_up : Icons.trending_down;
    // Personnalisation de la couleur de la carte en fonction de la tendance.
    final Color cardColor = isUp ? Colors.green[50]! : Colors.red[50]!;
    final Color textColor = isUp ? Colors.green : Colors.red;

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: () {
          // Navigation vers la page de détail avec les données boursières lorsque la carte est tapée.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPage(stockData: stockData),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          stockData['name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[850],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          stockData['symbol'],
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[600]),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                height: 100, // Increased height for a better visual
                child: GraphiqueBourse(),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '\$${stockData['price'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[850],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(iconData, color: textColor, size: 20.0),
                      Text(
                        '${stockData['change'].toStringAsFixed(2)} (${stockData['changesPercentage'].toStringAsFixed(2)}%)',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
