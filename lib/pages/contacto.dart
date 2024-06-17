import 'package:flutter/material.dart';

class ContactoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '¡Contáctanos!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff087bd9),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Ubicación:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff087bd9),
                ),
              ),
              const Text('Avenida Miguel de la Madrid'),
              const SizedBox(height: 16),
              const Text(
                'Teléfono:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff087bd9),
                ),
              ),
              const Text('555-123-4567'),
              const SizedBox(height: 16),
              const Text(
                'Correo electrónico:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff087bd9),
                ),
              ),
              const Text('info@petco.com'),
            ],
          ),
        ),
      ),
    );
  }
}
