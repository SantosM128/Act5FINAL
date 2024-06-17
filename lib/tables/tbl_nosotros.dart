import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NosotrosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Nosotros',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff087bd9),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Tabla', icon: Icon(Icons.list, color: Colors.white)),
              Tab(
                  text: 'Datos',
                  icon: Icon(Icons.list_alt, color: Colors.white)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NosotrosDatos(),
            NosotrosFormulario(),
          ],
        ),
      ),
    );
  }
}

class NosotrosFormulario extends StatefulWidget {
  const NosotrosFormulario({Key? key}) : super(key: key);

  @override
  _NosotrosFormularioState createState() => _NosotrosFormularioState();
}

class _NosotrosFormularioState extends State<NosotrosFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idSucursalController = TextEditingController();
  final TextEditingController _idUbicacionController = TextEditingController();
  final TextEditingController _idGerenteController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _horarioController = TextEditingController();
  final TextEditingController _preguntasSugController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('nosotros').add({
        'IdSucursal': _idSucursalController.text,
        'idUbicacion': _idUbicacionController.text,
        'idGerente': _idGerenteController.text,
        'Email': _emailController.text,
        'Horario': _horarioController.text,
        'PreguntasSug': _preguntasSugController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos añadidos exitosamente')),
      );

      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _idSucursalController,
              decoration: InputDecoration(
                labelText: 'ID Sucursal',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID de la sucursal';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idUbicacionController,
              decoration: InputDecoration(
                labelText: 'ID Ubicación',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID de la ubicación';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idGerenteController,
              decoration: InputDecoration(
                labelText: 'ID Gerente',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del gerente';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _horarioController,
              decoration: InputDecoration(
                labelText: 'Horario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _preguntasSugController,
              decoration: InputDecoration(
                labelText: 'Preguntas y Sugerencias',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Datos'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff087bd9),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NosotrosDatos extends StatelessWidget {
  const NosotrosDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('nosotros').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text(
                'Sucursal: ${doc['IdSucursal']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ubicación: ${doc['idUbicacion']}'),
                  Text('Gerente: ${doc['idGerente']}'),
                  Text('Email: ${doc['Email']}'),
                  Text('Horario: ${doc['Horario']}'),
                  Text('Preguntas y Sugerencias: ${doc['PreguntasSug']}'),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
