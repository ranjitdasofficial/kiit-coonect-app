import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewPdf extends StatefulWidget {
  const ViewPdf({super.key, required this.file});

  final File file;

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pdf View"),
      ),
      body: Container(
        child: PDFView(
          filePath: widget.file.path,
          pageSnap: false,
          pageFling: false,
          // enableSwipe: true,
          // swipeHorizontal: false,
          // fitEachPage: false,
          // autoSpacing: false,
          // pageFling: false,

          onRender: (pages) {
            setState(() {
              pages = pages;
              isReady = true;
            });
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },

          onViewCreated: (controller) {
            _controller.complete(controller);
          },
          // onViewCreated: (PdfViewerController pdfViewController) {
          //   _controller.complete(pdfViewController);
          // },
          onPageChanged: (page, total) {
            print('page change: $page/$total');
          },
          // onPageChanged: (int page, int total) {

          // },
        ),
      ),
    );
  }
}
