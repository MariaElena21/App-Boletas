import 'package:app_boleta/main.dart';
import 'package:flutter/material.dart';

Color c1 = Color(0xFFD71118);
Color c2 = Color(0xFF59992F);
Color c3 = Color(0xFF64B3B6);
Color c4 = Color(0xFFFFFFFF);

void main() {
  runApp(CambiarContrasena());
}

class CambiarContrasena extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: c3,
          title: Text(
              'Cambiar Clave',
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
        body: CambiarContrasenaForm(),

      ),
    );
  }
}

class CambiarContrasenaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Se requiere cambio de contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.0),
              Text(
                'Por razones de seguridad, debe cambiar su contraseña.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    PasswordField(icon: Icons.lock, hintText: 'Nueva contraseña'),
                    SizedBox(height: 10.0),
                    PasswordField(icon: Icons.lock, hintText: 'Confirmar contraseña'),
                    SizedBox(height: 20.0),
                    ButtonCanbiar(),
                    Cancelar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonCanbiar extends StatelessWidget {
  const ButtonCanbiar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: this.CustomElevatedButton(
        text: 'Cambiar Contraseña',
        onPressed: () {

        },
        color: c2,
      ),
    );
  }

  Widget CustomElevatedButton({required String text, required Function() onPressed, required Color color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: c3,
        elevation: 10, // Elevación del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(text),
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


class PasswordField extends StatefulWidget {
  final IconData icon;
  final String hintText;

  PasswordField({required this.icon, required this.hintText});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: c2), // Cambia el color del borde aquí
        ),
      ),
    );
  }
}