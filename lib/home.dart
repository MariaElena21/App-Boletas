import 'dart:convert';
import 'package:app_boleta/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_boleta/lista.dart';
import 'package:app_boleta/cambiar.dart';


Color c1 = Color(0xFFD71118);
Color c2 = Color(0xFF59992F);
Color c3 = Color(0xFF64B3B6);
Color c4 = Color(0xFFFFFFFF);



class Home extends StatelessWidget {

  final String name;
  final String dni;

  Home({required this.name, required this.dni});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(name: name, dni: dni),
    );
  }
}

class HomePage extends StatelessWidget {
  final String name;
  final String dni;

  HomePage({required this.name, required this.dni});

  @override
  Widget build(BuildContext context) {

    // Dividir el nombre completo en primer nombre y primer apellido
    List<String> nameParts = name.split(" ");
    String firstName = nameParts.length > 2 ? nameParts[2] : "";
    String lastName = nameParts.isNotEmpty ? nameParts[0] : "";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Muestra el menú desplegable
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'Opciones del Menú',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Divider(
                        height: 1, // Ajusta el espacio entre divisiones
                        thickness: 0.4, // Ajusta el grosor de la línea de división
                      ),
                      ListTile(
                        leading: Icon(Icons.search),
                        title: Text('Lista de Boletas'),
                        onTap: () async {
                          // Construir el JSON
                          Map<String, dynamic> jsonData = {"dni": dni};
                          // Realizar la solicitud HTTP
                          var headers = {
                            'Cookie': 'JPP240419=dbce8797144681c9667bd74d2ffa9fd3',
                            'Content-Type': 'application/json'
                          };
                          var response = await http.post(
                            Uri.parse('https://apisms.phuyufact3.com/api/listar-boletas'),
                            headers: headers,
                            body: json.encode(jsonData),
                          );

                          if (response.statusCode == 200) {
                            // Analizar la respuesta JSON
                            Map<String, dynamic> jsonResponse = json.decode(response.body);
                            bool state = jsonResponse['state'];

                            if (state == true) {
                              print(response.body);
                              // Navegar a la pantalla Lista si el estado es true
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Lista(documentList: jsonResponse['text'])),
                              );
                            }

                          } else {
                            print(response.reasonPhrase);
                          }
                        },
                      ),
                      SizedBox(height: 5),
                      Divider(
                        height: 1, // Ajusta el espacio entre divisiones
                        thickness: 0.4, // Ajusta el grosor de la línea de división
                      ),
                      ListTile(
                        leading: Icon(Icons.lock_reset),
                        title: Text('Cambiar clave'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CambiarContrasena()), // Navega a ListaScreen
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      Divider(
                        height: 1, // Ajusta el espacio entre divisiones
                        thickness: 0.4, // Ajusta el grosor de la línea de división
                      ),
                      ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Cerrar Sesión'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white, // Color de fondo del AlertDialog
                                  title: Text("Cerrar Sesión",textAlign: TextAlign.center),
                                  content: Text("¿Estás seguro que deseas cerrar sesión?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Cierra el diálogo sin hacer nada
                                      },
                                      child: Text("No",style: TextStyle(color: Colors.black)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => Bienvenido()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: c2, // Color de fondo del botón Yes (Sí)
                                      ),
                                      child: Text("Sí", style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                );


                              },
                            );
                          }
                      ),
                    ],
                  ),
                )
                );

              },
            );
          },
        ),




        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white, // Color de fondo del AlertDialog
                    title: Text("Cerrar Sesión",textAlign: TextAlign.center),
                    content: Text("¿Estás seguro que deseas cerrar sesión?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el diálogo sin hacer nada
                        },
                        child: Text("No",style: TextStyle(color: Colors.black)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Bienvenido()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c2, // Color de fondo del botón Yes (Sí)
                        ),
                        child: Text("Sí", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de la aplicación
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imagen1.png'), // Ruta de tu imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
            child:  Container(
              color: Color.fromRGBO(0, 0, 0, 0.30), // Opacidad del 1%
            ),
          ),
          // Contenido principal de la aplicación
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Color de fondo del contenedor
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0), // Radio de borde para la esquina inferior izquierda
                    bottomRight: Radius.circular(100.0), // Radio de borde para la esquina inferior derecha
                  ),
                ),
                padding: EdgeInsets.all(16.0), // Padding para el contenido dentro del contenedor
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child:
                    Text(
                      'Bienvenido',
                      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Primer nombre
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  firstName,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              SizedBox(width: 10), // Espacio entre los Text widgets
                              Flexible(
                                child: Text(
                                  lastName,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
