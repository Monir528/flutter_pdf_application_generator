import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewer extends StatelessWidget {
  const PDFViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PDFView(
      filePath: '/storage/emulated/0/Android/data/com.example.diu_application_generator/files/hccynew_document.pdf',
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
    ),
    );
  }
}
