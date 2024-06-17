import 'package:flutter/material.dart';

class ConclusionesPage extends StatelessWidget {
  const ConclusionesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Conclusiones'),
        backgroundColor: const Color(0xffe8a96c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Aqui hice mi proyecto con lo que hicimos este parcial como el uso de imagenes y base de datos.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
