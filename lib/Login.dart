import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginCard extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  LoginCard({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  // Déclaration et initialisation des contrôleurs pour les champs de texte d'email et de mot de passe.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Méthode asynchrone pour gérer le processus de connexion.
  Future<void> _login() async {
    try {
      // Tentative de connexion avec Supabase en utilisant l'email et le mot de passe fournis.
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Si la réponse contient un utilisateur, cela signifie que la connexion a réussi.
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Connexion réussit."),
          backgroundColor: Colors.green,
        ));
        widget.onLoginSuccess(); // Invoke the callback when login is successful
      } else {
        // Affichage d'un message d'erreur si aucun utilisateur n'est retourné.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("La connexion à échoué pour une raison inconnue !"),
          backgroundColor: Colors.red,
        ));
      }
    } on AuthException catch (e) {
      // Gestion des exceptions liées à l'authentification.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur durant la connexion : ${e.message}"),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      // Gestion des autres types d'erreurs.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Une erreur est parvenue !"),
        backgroundColor: Colors.red,
      ));
      print('Login error: $e');
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
              // Champ de texte pour l'email.
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintStyle: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              // Champ de texte pour le mot de passe, masqué pour la confidentialité.
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintStyle: TextStyle(color: Colors.blue),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Bouton de connexion qui déclenche la méthode _login.
              ElevatedButton(
                onPressed: _login,
                child: const Text(
                  'Connexion',
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
