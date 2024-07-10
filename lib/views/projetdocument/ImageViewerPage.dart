import 'package:flutter/material.dart';
import 'dart:io';

class ImageViewerPage extends StatelessWidget {
  final String imagePath;

  const ImageViewerPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
