import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './graphiqueBourse.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> stockData;

  const DetailPage({Key? key, required this.stockData}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? companyOutlook;

  @override
  void initState() {
    super.initState();
    fetchCompanyOutlook();
  }

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
      throw Exception('Echec du chargement des données !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockData['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: companyOutlook == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Symbol: ${widget.stockData['symbol']}",
                      style: TextStyle(fontSize: 16)),
                  Text(
                      "Price: \$${widget.stockData['price'].toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16)),
                  Text("52 Week High/Low: ${companyOutlook?['range']}",
                      style: TextStyle(fontSize: 16)),
                  Text("Market Cap: \$${companyOutlook?['mktCap']}",
                      style: TextStyle(fontSize: 16)),
                  Text("Beta: ${companyOutlook?['beta'].toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16)),
                  Divider(),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          GraphiqueBourse(), // Assurez-vous d'avoir ce widget défini ailleurs
                    ),
                  ),
                  Divider(),
                  Text("CEO: ${companyOutlook?['ceo']}",
                      style: TextStyle(fontSize: 16)),
                  Text("Country: ${companyOutlook?['country']}",
                      style: TextStyle(fontSize: 16)),
                  Text("Sector: ${companyOutlook?['sector']}",
                      style: TextStyle(fontSize: 16)),
                  Text("Industry: ${companyOutlook?['industry']}",
                      style: TextStyle(fontSize: 16)),
                  Text(
                      "Full Time Employees: ${companyOutlook?['fullTimeEmployees']}",
                      style: TextStyle(fontSize: 16)),
                  Divider(),
                  Text("Description:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(companyOutlook?['description'] ?? 'N/A',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
      ),
    );
  }
}
