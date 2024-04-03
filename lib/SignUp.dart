import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupCard extends StatefulWidget {
  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  // Initialisation des contrôleurs pour gérer les champs de texte.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fonction asynchrone pour gérer l'inscription d'un nouvel utilisateur.
  Future<void> _signup() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    // You may want to add validation for the input fields here before proceeding

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      // Vérification si l'utilisateur a été créé avec succès.
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Inscription réussit."),
          backgroundColor: Colors.green,
        ));
        // Redirect the user or perform other actions
      } else {
        // Affichage d'un message d'échec.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Inscription échoué"),
          backgroundColor: Colors.red,
        ));
      }
    } on AuthException catch (e) {
      // Gestion des exceptions liées à l'authentification.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur inscription : ${e.message}"),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      // Gestion des autres exceptions.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Une erreur est parvenue !"),
        backgroundColor: Colors.red,
      ));
      print('Erreur inscription : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Champ pour le pseudo de l'utilisateur.
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Pseudo',
                  hintStyle: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              // Champ pour l'email.
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintStyle: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              // Champ pour le mot de passe, masqué pour la confidentialité.
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintStyle: TextStyle(color: Colors.blue),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Bouton pour soumettre le formulaire d'inscription.
              ElevatedButton(
                onPressed: _signup, // Call the signup function here
                child: const Text(
                  'Inscription',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
