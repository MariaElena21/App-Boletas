import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';


Color c1 = Color(0xFFD71118);
Color c2 = Color(0xFF59992F);
Color c3 = Color(0xFF64B3B6);
Color c4 = Color(0xFFFFFFFF);

class VistaPDF extends StatefulWidget {
  final String pdfUrl;
  final String documentName;

  VistaPDF({required this.pdfUrl, required this.documentName});

  @override
  _VistaPDFState createState() => _VistaPDFState();
}

class _VistaPDFState extends State<VistaPDF> {
  double? _downloadProgress;

  void _startDownload(String url, String documentName) async{

    await Permission.storage.request();
    String pdfUrl = url;
    String fileName = documentName.endsWith('.pdf') ? documentName : '$documentName.pdf';

    FileDownloader.downloadFile(
      url: pdfUrl,
      name: fileName,
      onProgress: (name, progress) {
        setState(() {
          _downloadProgress = progress;

        });
      },
      onDownloadCompleted: (value) {
        // Puedes imprimir la ruta de descarga si lo deseas
        print('Descarga completada. Ruta: $value');
        setState(() {
          _downloadProgress = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Archivo descargado con exito'),
          ),
        );
      },

    );
  }
  void _shareURL(String url, String documentName) async{
    await Permission.storage.request();
    String pdfUrl = url;
    String fileName = documentName.endsWith('.pdf') ? documentName : '$documentName.pdf';

    FileDownloader.downloadFile(
      url: pdfUrl,
      name: fileName,
      onProgress: (name, progress) {
      },
    onDownloadCompleted: (value) async {

        final result = await Share.shareXFiles([XFile('$value')]);
        if (result.status == ShareResultStatus.success) {
          print('Se descargó correctamente!');
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c2,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
            color: c4,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Visor de PDF',
          style: TextStyle(
            color: c4, // Color c4 para el texto
          ),
          textAlign: TextAlign.center, // Centra el texto
        ),
        centerTitle: true,

        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50), // Ajusta el valor según tu preferencia
        ),
        ),
      ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      child: SfPdfViewer.network(
                        widget.pdfUrl,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _startDownload(widget.pdfUrl, widget.documentName);
                },
                backgroundColor: c1,
                child: _downloadProgress != null
                    ? CircularProgressIndicator(
                      color: c4,
                      strokeWidth: 2.0,
                )
                    : Icon(
                    Icons.download,
                    color: c4,
                ),
              ),
              SizedBox(width: 16),
              FloatingActionButton(
                onPressed: () {
                  _shareURL(widget.pdfUrl, widget.documentName);
                },
                backgroundColor: c2,
                child:
                     Icon(
                    Icons.share,
                    color: c4,
                ),
              ),
            ],
          ),


    );
  }
}
