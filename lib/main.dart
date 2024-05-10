import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_boleta/home.dart';
import 'package:app_boleta/recuperar.dart';
import 'dart:convert';

Color c1 = const Color(0xFFD71118);
Color c2 = const Color(0xFF59992F);
Color c3 = const Color(0xFF64B3B6);
Color c4 = const Color(0xFFFFFFFF);

void main() {
  runApp(Bienvenido());
}

class Bienvenido extends StatelessWidget {
  const Bienvenido({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c4,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20.0,
              MediaQuery.of(context).size.height *
                  0.1, // 20% de la altura de la pantalla como espacio superior
              20.0,
              MediaQuery.of(context).size.height *
                  0.1, // 20% de la altura de la pantalla como espacio inferior
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Logo(),
                Contenedor(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Contenedor extends StatefulWidget {
  @override
  _ContenedorState createState() => _ContenedorState();
}

class _ContenedorState extends State<Contenedor> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Bienvenidos(),
          SizedBox(height: 20.0),
          TextField(
            controller: dniController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'DNI',
            ),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              suffixIcon: IconButton(
                icon: _obscureText
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Button_Ingresar(),
          SizedBox(height: 30.0),
          Button_Clic_Aqui(),
        ],
      ),
    );
  }
}

class Button_Ingresar extends StatefulWidget {

  const Button_Ingresar({
    Key? key,
  }) : super(key: key);

  @override
  State<Button_Ingresar> createState() => _Button_IngresarState();
}

class _Button_IngresarState extends State<Button_Ingresar> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        login(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: c2,
        elevation: 10, // Elevación del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text('Ingresar'),
    );
  }

  Future<void> login(BuildContext context) async {
    String dni = dniController.text;
    String password = passwordController.text;

    if (dni.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: const Text('Error'),
            ),
            content: const Text('Los campos no pueden estar vacíos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // Color del texto negro
                ),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      return; // Salir del método si hay campos vacíos
    }

    // Definir el cuerpo de la solicitud como un mapa
    Map<String, dynamic> body = {
      "user": dni,
      "password": password,
    };

    // Convertir el cuerpo a JSON
    String jsonBody = json.encode(body);

    // Definir los encabezados de la solicitud
    var headers = {
      'Cookie': 'JPP240419=dbce8797144681c9667bd74d2ffa9fd3',
      'Content-Type': 'application/json'
    };

    var request = http.Request('POST', Uri.parse('https://apisms.phuyufact3.com/api/login'));
    request.body = jsonBody;
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      // Comprobar el código de estado de la respuesta
      if (response.statusCode == 200) {
        // Leer y analizar la respuesta JSON
        var jsonResponse = json.decode(await response.stream.bytesToString());

        // Guardar los campos en variables
        bool state = jsonResponse['state'];
        //String text = jsonResponse['text'];
        String name = jsonResponse['name'];
        String dni = jsonResponse['dni'];

        if (state == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home(name:name,dni: dni)),
          );
          print("bien");
        } else {
          // Verificar si la clave 'text' existe en el JSON antes de intentar acceder a su valor
          if (jsonResponse.containsKey('text')) {
            print(jsonResponse['text']); // Mostrar el mensaje de error
          } else {
            print("Error: La clave 'text' no existe en la respuesta JSON.");
          }
        }

      } else {
        // Error
        print(response.reasonPhrase);
        // Aquí puedes emitir un mensaje de error como un diálogo o un SnackBar
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                "Error",
                textAlign: TextAlign.center,
              ),
            ),
            content: Text("DNI o Contraseña incorrectos",
                textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cerrar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: c2,
                  ),),
              ),
            ],
          );
        },
      );
      print("errorrrr");
    }
  }
}

class Bienvenidos extends StatelessWidget {
  const Bienvenidos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bienvenidos',
        style:
        TextStyle(fontSize: 40.0, color: c2, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Button_Clic_Aqui extends StatelessWidget {
  const Button_Clic_Aqui({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: '¿Olvidaste tu contraseña? ',
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'Haz clic aquí',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecuperarContrasena()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Image.asset('assets/ecosac-logo.png', width: 160, height: 160),
    );
  }
}

TextEditingController dniController = TextEditingController();
TextEditingController passwordController = TextEditingController();
