import 'package:app_boleta/main.dart';
import 'package:flutter/material.dart';
Color c1 = Color(0xFFD71118);
Color c2 = Color(0xFF59992F);
Color c3 = Color(0xFF64B3B6);
Color c4 = Color(0xFFFFFFFF);

void main() {
  runApp(Recuperar());
}

class Recuperar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecuperarContrasena(),
    );
  }
}

class RecuperarContrasena extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c3,
        title: Text(
            'Recuperar Contraseña',
            style: TextStyle(
              color: c4,
            ),
            textAlign: TextAlign.center
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: c4,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            )
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        '¿Olvidó su contraseña? Siga los siguientes pasos:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                          'Se enviará un código de verificacion a su correo electrónico. Por favor, ingrese los datos correctos.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 16
                          ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email), // Icono de correo a la izquierda
                          hintText: 'Correo electrónico',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: c2), // Cambia el color del borde aquí
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Lógica para enviar el correo electrónico
                            },
                            icon: Icon(Icons.send), // Icono de enviar a la derecha
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Tiene # segundos para ingresar el código de verificación.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.emergency), // Icono de código a la izquierda
                          hintText: 'Código',
                          contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: c2), // Cambia el color del borde aquí
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Lógica para validar el código
                            },
                            icon: Icon(Icons.check), // Icono de validar a la derecha
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Cancelar(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Cancelar extends StatelessWidget {
  const Cancelar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: this.CustomElevatedButton(
        text: 'Cancelar',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white, // Color de fondo del AlertDialog
                title: Text("Cancelar"),
                content: Text("¿Estás seguro que quieres cancelar los cambios?"),
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
        color: c2,
      ),
    );
  }

  Widget CustomElevatedButton({required String text, required Function() onPressed, required Color color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: c3,width: 2.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(text),
    );
  }
}

