import 'package:flutter/material.dart';

class CustomLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Utilisez les couleurs de votre marque
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/vic1.jpeg',
              height: 150,
              width: 150,
            ), // Remplacez par votre logo
            SizedBox(height: 16),
            CircularProgressIndicator(), // Indicateur de chargement
            SizedBox(height: 16),
            const Text(
              'Chargement en cours...', // Message de chargement
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
