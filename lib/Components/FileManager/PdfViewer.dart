import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  PdfViewer({super.key, this.id, this.name});

  String? id;
  String? name;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  List<FileSystemEntity> list = [];
  Dio dio = Dio();

  final double _downloadProgress = 0;
  var count = 5;

  getFiles() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Directory pdfDir = Directory('${dir.path}/pdfFiles');

    setState(() {
      list = pdfDir.listSync();
      count = list.length;
    });

    print(list);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _createDirectory();
    // getFiles();
    // _downloadFile("https://drive.google.com/uc?export=download&id=${widget.id}",
    //     "${widget.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pdf Viewr"),
        ),
        body: Container(
            child: Center(
          child: ElevatedButton(
              onPressed: () {
                // _downloadFile(
                //     "https://drive.google.com/uc?export=download&id=${widget.id}",
                //     "files-$count");
              },
              child: Text("Downlload- ${_downloadProgress * 100}")),
        )));
  }
}
