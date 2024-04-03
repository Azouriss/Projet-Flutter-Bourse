import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './dataBourse.dart';

void main() {
  // Initialisation de Supabase avec l'URL du projet et la clé anonyme.
  Supabase.initialize(
    url:
        'https://tsjfrbclthhouvdqpddj.supabase.co', // Remplacez par votre URL de projet Supabase
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRzamZyYmNsdGhob3V2ZHFwZGRqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA5NDc3MTYsImV4cCI6MjAyNjUyMzcxNn0.6YAt7IIxMGlWjY8qmXnbwJYMb1hoOWYi1wbxcytSuDY', // Remplacez par votre clé anonyme Supabase
  );
  // Démarrage de l'application Flutter
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DataBourse(),
    );
  }
}
