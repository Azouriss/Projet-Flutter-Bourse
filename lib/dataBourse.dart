import 'package:flutter/material.dart';

import './infoDataGraphique.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class DataBourse extends StatefulWidget {
  const DataBourse({Key? key}) : super(key: key);

  @override
  State<DataBourse> createState() => _DataBourseState();
}

class _DataBourseState extends State<DataBourse> {
  List<String> stockData = [];

  @override
  void initState() {
    super.initState();
    fetchData(['AAPL', 'AMZN']);
  }

  Future<void> fetchData(List<String> symbols) async {
    List<String> stockInfoData = [];
    for (String symbol in symbols) {
      try {
        final response = await getData(symbol);
        if (response.statusCode == 200) {
          stockInfoData.add(response.body);
        } else {
          stockInfoData.add('Erreur de chargement pour: $symbol');
        }
      } catch (e) {
        stockInfoData.add('Erreur de chargement pour: $symbol: $e');
      }
    }
    setState(() {
      stockData = stockInfoData;
    });
  }

  Future<http.Response> getData(String symbol) async {
    const apiKey = 'ecc918ef30870f196bf3f32db6ed23fe';
    final authority = 'financialmodelingprep.com';
    final path = '/api/v3/quote/$symbol';

    final parameters = {
      'apikey': apiKey,
    };

    final uri = Uri.https(authority, path, parameters);
    return await http.get(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MazeBourse & Co",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marché des Actions',
                style: TextStyle(fontSize: 22, color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ...stockData.map((data) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InfoDataGraphique(data: data), // Utilisez votre widget StockInfoTile ici
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}