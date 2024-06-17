import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SucursalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sucursales',
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
            SucursalDatos(),
            SucursalFormulario(),
          ],
        ),
      ),
    );
  }
}

class SucursalFormulario extends StatefulWidget {
  const SucursalFormulario({Key? key}) : super(key: key);

  @override
  _SucursalFormularioState createState() => _SucursalFormularioState();
}

class _SucursalFormularioState extends State<SucursalFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idSucursalController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _numExteriorController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('sucursales').add({
        'idSucursal': _idSucursalController.text,
        'Nombre': _nombreController.text,
        'Ciudad': _ciudadController.text,
        'Calle': _calleController.text,
        'NumExterior': _numExteriorController.text,
        'Telefono': _telefonoController.text,
        'Email': _emailController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sucursal añadida exitosamente')),
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
              controller: _ciudadController,
              decoration: InputDecoration(
                labelText: 'Ciudad',
                border: OutlineInputBorder(),
              ),
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
              controller: _numExteriorController,
              decoration: InputDecoration(
                labelText: 'Número Exterior',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
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
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Sucursal'),
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

class SucursalDatos extends StatelessWidget {
  const SucursalDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('sucursales').snapshots(),
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
              subtitle: Text(
                  'ID: ${doc['idSucursal']} - Teléfono: ${doc['Telefono']}'),
              trailing: Text(doc['Ciudad']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
