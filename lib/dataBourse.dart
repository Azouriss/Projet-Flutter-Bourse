// Importation des packages nécessaires à l'application.
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './infoDataCard.dart';
import './articles.dart';
import './Login.dart';
import './SignUp.dart';
import './infoArticles.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

// Déclaration de la classe StatefulWidget pour l'écran DataBourse.
class DataBourse extends StatefulWidget {
  // Constructeur de la classe avec une clé optionnelle.
  const DataBourse({Key? key}) : super(key: key);

  @override
  State<DataBourse> createState() => _DataBourseState();
}

class _DataBourseState extends State<DataBourse> {
  // Déclaration des variables d'état.
  List<String> stockData = [];
  bool isLoggedIn = false;

  @override
  // Initialisation de l'état.
  void initState() {
    super.initState();
    fetchData(['AAPL', 'AMZN', 'GOOG']);
    checkLoginStatus();
  }

  // Fonction pour vérifier si l'utilisateur est connecté
  void checkLoginStatus() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      isLoggedIn = user != null;
    });
  }

  // Fonction pour déconnecter l'utilisateur.
  void logout() async {
    await Supabase.instance.client.auth.signOut();
    setState(() {
      isLoggedIn = false;
    });
  }

  // Fonction asynchrone pour récupérer les données boursières des symboles spécifiés.
  Future<void> fetchData(List<String> symbols) async {
    List<String> stockInfoData = []; // Liste temporaire pour stocker les données.
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

  // Fonction asynchrone pour envoyer une requête HTTP et récupérer les données boursières.
  Future<http.Response> getData(String symbol) async {
    const apiKey = 'ecc918ef30870f196bf3f32db6ed23fe';
    final authority = 'financialmodelingprep.com';
    final path = '/api/v3/quote/$symbol';

    final parameters = {
      'apikey': apiKey,
    };

    final uri = Uri.https(authority, path, parameters); // Construction de l'URI pour la requête.
    return await http.get(uri);
  }

  @override
  // Fonction de construction de l'interface utilisateur.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MazeBourse & Co",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
        actions: <Widget>[
          // Si l'utilisateur n'est pas connecté, montre le bouton de connexion.
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
                'Connexion',
                style: TextStyle(color: Colors.white),
              ),
            ),
          // Si l'utilisateur n'est pas connecté, montre également le bouton d'inscription.
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
                'Inscription',
                style: TextStyle(color: Colors.white),
              ),
            ),
          // Si l'utilisateur est connecté, montre le bouton de déconnexion.
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
          // Permet le défilement si le contenu dépasse l'écran.
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
              // Mappe les données boursières à des widgets pour l'affichage.
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
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => infoArticles(),
                      ),
                    );
                  },
                  child: const Text(
                    'En savoir plus ...',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              // Affiche des cartes d'articles dans une ligne, permettant de parcourir horizontalement.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // Utilise la fonction articleCard pour créer des cartes pour chaque article.
                children: [
                  articleCard('Titre 1', 'Description de l\'article 1...', context),
                  articleCard('Titre 2', 'Description de l\'article 2...', context),
                  articleCard('Titre 3', 'Description de l\'article 3...', context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
