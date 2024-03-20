import 'package:flutter/material.dart';
import 'dart:convert';

class InfoDataGraphique extends StatelessWidget {
  final String data;

  const InfoDataGraphique({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> stockData = json.decode(data)[0];

    final bool isUp = stockData['change'] >= 0;
    final IconData iconData = isUp ? Icons.arrow_upward : Icons.arrow_downward;
    final Color textColor = isUp ? Colors.green : Colors.red;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stockData['name'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stockData['symbol'],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.show_chart),
                  onPressed: () {
                    // Implémentez la navigation vers une vue détaillée
                  },
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '\$${stockData['price'].toStringAsFixed(2)}', // Formate le prix à deux décimales
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(iconData, color: textColor),
                Text(
                  '${stockData['change'].toStringAsFixed(2)} (${stockData['changesPercentage'].toStringAsFixed(2)}%)',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}