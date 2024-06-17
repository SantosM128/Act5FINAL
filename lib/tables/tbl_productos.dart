import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Productos',
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
            ProductoDatos(),
            ProductoFormulario(),
          ],
        ),
      ),
    );
  }
}

class ProductoFormulario extends StatefulWidget {
  const ProductoFormulario({Key? key}) : super(key: key);

  @override
  _ProductoFormularioState createState() => _ProductoFormularioState();
}

class _ProductoFormularioState extends State<ProductoFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _origenController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('productos').add({
        'id_producto': _idController.text,
        'codigo': _codigoController.text,
        'nombre': _nombreController.text,
        'precio': double.tryParse(_precioController.text) ?? 0.0,
        'marca': _marcaController.text,
        'categoria': _categoriaController.text,
        'origen': _origenController.text,
        'descripcion': _descripcionController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto añadido exitosamente')),
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
                labelText: 'ID Producto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del producto';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _codigoController,
              decoration: InputDecoration(
                labelText: 'Código',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre Producto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre del producto';
                }
                return null;
              },
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
                  return 'Por favor ingrese el precio del producto';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _marcaController,
              decoration: InputDecoration(
                labelText: 'Sucursal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _categoriaController,
              decoration: InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
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
              controller: _origenController,
              decoration: InputDecoration(
                labelText: 'Total Venta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Producto'),
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

class ProductoDatos extends StatelessWidget {
  const ProductoDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('productos').snapshots(),
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
                doc['nombre'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'ID: ${doc['id_producto']} - Precio: \$${doc['precio']}'),
              trailing: Text(doc['categoria']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
