import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class PdfViewerPage extends StatefulWidget {
  final String url;

  const PdfViewerPage({Key? key, required this.url}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    downloadAndSaveFile(widget.url, 'downloaded.pdf').then((file) {
      setState(() {
        localPath = file.path;
      });
    });
  }

  Future<File> downloadAndSaveFile(String url, String fileName) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      File file = File(filePath);

      // Télécharger le fichier PDF depuis l'URL
      Response response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      // Écrire les bytes téléchargés dans le fichier
      await file.writeAsBytes(response.data, flush: true);
      return file;
    } catch (e) {
      print("Error downloading file: $e");
      throw Exception("Error downloading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document View'),
      ),
      body: localPath != null
          ? PDFView(
              filePath: localPath!,
            )
          : Center(child: CircularProgressIndicator(
            color: Colors.green,
            backgroundColor: Color(0x13B1561A),
          )),
    );
  }
}
