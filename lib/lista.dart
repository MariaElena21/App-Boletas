import 'package:flutter/material.dart';
import 'package:app_boleta/vistaPDF.dart';

Color c1 = Color(0xFFD71118);
Color c2 = Color(0xFF59992F);
Color c3 = Color(0xFF64B3B6);
Color c4 = Color(0xFFFFFFFF);

class Lista extends StatelessWidget {
  final List<dynamic> documentList;
  Lista({required this.documentList});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: c2,
            title: Text(
              'Lista de Boletas',
              style: TextStyle(
                color: c4, // Color c4 para el texto
              ),
              textAlign: TextAlign.center, // Centra el texto
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
                bottom: Radius.circular(50), // Ajusta el valor según tu preferencia
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: documentList.length,
            itemBuilder: (context, index) {
              var document = documentList[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(document['name']), // Título con el nombre del documento
                  subtitle: Text(document['document']), // Subtítulo con el número del documento
                  trailing: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VistaPDF(pdfUrl: document['url'], documentName: document['name'],)),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
