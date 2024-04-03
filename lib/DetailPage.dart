import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './graphiqueBourse.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> stockData; // Données de l'entreprise passées au widget.

  const DetailPage({Key? key, required this.stockData}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? companyOutlook; // Pour stocker les données supplémentaires de l'entreprise.

  @override
  void initState() {
    super.initState();
    fetchCompanyOutlook(); // Récupère les données de l'entreprise lors de l'initialisation.
  }

  // Fonction asynchrone pour récupérer des informations supplémentaires sur l'entreprise.
  Future<void> fetchCompanyOutlook() async {
    final String apiKey = 'ecc918ef30870f196bf3f32db6ed23fe';
    final String symbol = widget.stockData['symbol'];
    final response = await http.get(
      Uri.parse(
          'https://financialmodelingprep.com/api/v3/profile/$symbol?apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List && data.isNotEmpty) {
        setState(() {
          companyOutlook = data[0];
        });
      }
    } else {
      throw Exception('Erreur de chargement Data !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.stockData['name'],
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Affiche un indicateur de progression si les données de l'entreprise ne sont pas encore chargées.
        child: companyOutlook == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    color: Colors.blueGrey[50],
                    child: ListTile(
                      title: Text(widget.stockData['symbol'],
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        widget.stockData['name'],
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      ),
                      trailing: Chip(
                        label: Text(
                            '\$${widget.stockData['price'].toStringAsFixed(2)}'),
                        backgroundColor: Colors.blueGrey[100],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.blueGrey[900],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            GraphiqueBourse(), // Make sure to have this widget defined elsewhere
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Company Overview",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Plusieurs appels à `buildDetailItem` pour chaque paire, plus efficace.
                  buildDetailItem("CEO", companyOutlook?['ceo'] ?? 'N/A'),
                  buildDetailItem(
                      "Country", companyOutlook?['country'] ?? 'N/A'),
                  buildDetailItem("Sector", companyOutlook?['sector'] ?? 'N/A'),
                  buildDetailItem(
                      "Industry", companyOutlook?['industry'] ?? 'N/A'),
                  buildDetailItem(
                      "Market Cap", companyOutlook?['mktCap'] ?? 'N/A'),
                  buildDetailItem(
                      "52 Week High/Low", companyOutlook?['range'] ?? 'N/A'),
                  buildDetailItem("Beta",
                      companyOutlook?['beta']?.toStringAsFixed(2) ?? 'N/A'),
                  buildDetailItem(
                      "Full Time Employees",
                      companyOutlook?['fullTimeEmployees']?.toString() ??
                          'N/A'),
                  Divider(),
                  SizedBox(height: 10),
                  Text(
                    "Description:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    companyOutlook?['description'] ??
                        'No description available.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }

  // Construit un widget pour afficher une paire d'informations sur l'entreprise. Centraliser tout cela.
  Widget buildDetailItem(String label, dynamic value) {
    // Convertit la valeur en String, quelle que soit son type original
    String stringValue =
        (value is int || value is double) ? value.toString() : value ?? 'N/A';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text("$label:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Expanded(
              flex: 3,
              child: Text(stringValue, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
