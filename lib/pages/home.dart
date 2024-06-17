import 'package:flutter/material.dart';
import 'package:santos/main.dart';
import 'conclusiones.dart';
import 'package:santos/tables/tbl_servicios.dart';
import 'package:santos/tables/tbl_citas.dart';
import 'package:santos/tables/tbl_sucursal.dart';
import 'package:santos/tables/tbl_productos.dart';
import 'package:santos/tables/tbl_nosotros.dart';
import 'perfil.dart';
import 'contacto.dart';
import 'images.dart';

class PaginaInicio extends StatelessWidget {
  final String _email;

  const PaginaInicio(this._email, {Key? key}) : super(key: key);

  void _cerrarSesion(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PaginaSesion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Veterinaria',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontSize: 22,
            ),
          ),
          backgroundColor: const Color(0xff087bd9),
          elevation: 8,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xff087bd9),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://raw.githubusercontent.com/SantosM128/Img_IOS/main/FlutterFlowAct12/vet1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaginaInicio(_email)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: const Text('Productos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductosPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: const Text('Citas'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CitasPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.receipt),
                title: const Text('Sucursal'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SucursalPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('Productos vendidos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServiciosPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: const Text('Nosotros'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NosotrosPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: const Text('Conclusiones'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConclusionesPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  _cerrarSesion(context);
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '¡Bienvenido a Petco!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff087bd9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            ImagesPage(),
            PerfilPage(),
            ContactoPage(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home, color: Color(0xff000000)),
            ),
            Tab(
              icon: Icon(Icons.shopping_bag, color: Color(0xff000000)),
            ),
            Tab(
              icon: Icon(Icons.person, color: Color(0xff000000)),
            ),
            Tab(
              icon: Icon(Icons.contact_mail, color: Color(0xff000000)),
            ),
          ],
          labelColor: Color(0xff000000),
          unselectedLabelColor: Color(0xff000000),
          indicatorColor: Color(0xff000000),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }
}
