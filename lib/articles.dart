import 'package:flutter/material.dart';

// Widget pour afficher une carte d'article avec un titre, une description et un bouton "En savoir plus".
Widget articleCard(String title, String description) {
  return Expanded(
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
          TextButton(
            onPressed: () {
              // Logique pour "En savoir plus"
            },
            child: Text('En savoir plus'),
          ),
        ],
      ),
    ),
  );
}