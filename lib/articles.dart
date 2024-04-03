import 'package:flutter/material.dart';
import './infoArticles.dart';

// Définition de la fonction 'articleCard' qui prend en entrée le titre et la description de l'article.
Widget articleCard(String title, String description, BuildContext context) {
  return Expanded(
    child: Card(
      // Personnalisation de la forme de la carte avec des bords arrondis.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      // Ajout d'une élévation pour créer un effet d'ombre sous la carte.
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigation vers la page de détail avec les données boursières lorsque la carte est tapée.
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => infoArticles(),
                ),
              );
            },
            child: Text('En savoir plus'),
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
            ),
          ),
        ],
      ),
    ),
  );
}
