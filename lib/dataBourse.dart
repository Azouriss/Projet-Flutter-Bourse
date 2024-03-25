import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './infoDataCard.dart';
import './articles.dart';
import './Login.dart';
import './SignUp.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class DataBourse extends StatefulWidget {
  const DataBourse({Key? key}) : super(key: key);

  @override
  State<DataBourse> createState() => _DataBourseState();
}

class _DataBourseState extends State<DataBourse> {
  List<String> stockData = [];
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    fetchData(['AAPL', 'AMZN', 'GOOG']);
    checkLoginStatus();
  }

  void checkLoginStatus() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      isLoggedIn = user != null;
    });
  }

  void logout() async {
    await Supabase.instance.client.auth.signOut();
    setState(() {
      isLoggedIn = false;
    });
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
        actions: <Widget>[
          if (!isLoggedIn)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LoginCard(
                      onLoginSuccess: () {
                        Navigator.of(context).pop(); // Close the dialog
                        checkLoginStatus();
                      },
                    );
                  },
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (!isLoggedIn)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SignupCard();
                  },
                );
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (isLoggedIn)
            TextButton(
              onPressed: logout,
              child: const Text(
                'Déconnexion',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marché des Actions',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ...stockData
                  .map((data) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: InfoDataGraphique(data: data),
                      ))
                  .toList(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Actualités',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
              // Ici vous ajouterez vos articles et autres widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Vous pouvez créer un widget personnalisé pour ces cartes pour éviter la répétition du code
                  articleCard('Titre 1', 'Description de l\'article 1...'),
                  articleCard('Titre 2', 'Description de l\'article 2...'),
                  articleCard('Titre 3', 'Description de l\'article 3...'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
