import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiciosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Servicios',
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
            ServicioDatos(),
            ServicioFormulario(),
          ],
        ),
      ),
    );
  }
}

class ServicioFormulario extends StatefulWidget {
  const ServicioFormulario({Key? key}) : super(key: key);

  @override
  _ServicioFormularioState createState() => _ServicioFormularioState();
}

class _ServicioFormularioState extends State<ServicioFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _idEmpleadoController = TextEditingController();
  final TextEditingController _idSucursalController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _tipoServicioController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('servicios').add({
        'IDservicio': _idController.text,
        'NombreServicio': _nombreController.text,
        'Descripcion': _descripcionController.text,
        'IdEmpleado': _idEmpleadoController.text,
        'idSucursal': _idSucursalController.text,
        'Precio': double.tryParse(_precioController.text) ?? 0.0,
        'TipoDeServicio': _tipoServicioController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Servicio añadido exitosamente')),
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
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID Servicio',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del servicio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre Servicio',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre del servicio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idEmpleadoController,
              decoration: InputDecoration(
                labelText: 'ID Empleado',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idSucursalController,
              decoration: InputDecoration(
                labelText: 'ID Sucursal',
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
                  return 'Por favor ingrese el precio del servicio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _tipoServicioController,
              decoration: InputDecoration(
                labelText: 'Tipo de Servicio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Servicio'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff8ddfff),
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

class ServicioDatos extends StatelessWidget {
  const ServicioDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('servicios').snapshots(),
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
                doc['NombreServicio'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('ID: ${doc['IDservicio']} - Precio: \$${doc['Precio']}'),
              trailing: Text(doc['TipoDeServicio']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
