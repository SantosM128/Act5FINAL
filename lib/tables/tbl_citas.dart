import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CitasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Citas',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff0a036d),
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
            CitasDatos(),
            CitasFormulario(),
          ],
        ),
      ),
    );
  }
}

class CitasFormulario extends StatefulWidget {
  const CitasFormulario({Key? key}) : super(key: key);

  @override
  _CitasFormularioState createState() => _CitasFormularioState();
}

class _CitasFormularioState extends State<CitasFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idCitaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _numTelfController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _sucursalCercanaController =
      TextEditingController();
  final TextEditingController _tipoServicioController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('citas').add({
        'idCita': _idCitaController.text,
        'Nombre': _nombreController.text,
        'NumTelf': _numTelfController.text,
        'Calle': _calleController.text,
        'SucursalCercana': _sucursalCercanaController.text,
        'TipodeServicio': _tipoServicioController.text,
        'Precio': double.tryParse(_precioController.text) ?? 0.0,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cita añadida exitosamente')),
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
              controller: _idCitaController,
              decoration: InputDecoration(
                labelText: 'ID Cita',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID de la cita';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _numTelfController,
              decoration: InputDecoration(
                labelText: 'Número de Teléfono',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el número de teléfono';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _calleController,
              decoration: InputDecoration(
                labelText: 'Calle',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _sucursalCercanaController,
              decoration: InputDecoration(
                labelText: 'Sucursal Cercana',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _tipoServicioController,
              decoration: InputDecoration(
                labelText: 'Tipo de Servicio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _precioController,
              decoration: InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el precio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Cita'),
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

class CitasDatos extends StatelessWidget {
  const CitasDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('citas').snapshots(),
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
                doc['Nombre'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('ID: ${doc['idCita']} - Precio: \$${doc['Precio']}'),
              trailing: Text(doc['TipodeServicio']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
