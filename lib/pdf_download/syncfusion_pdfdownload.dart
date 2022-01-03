import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion/pdf_download/mobile.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class Pdfdownload extends StatefulWidget {
  const Pdfdownload({Key key}) : super(key: key);

  @override
  _PdfdownloadState createState() => _PdfdownloadState();
}

class _PdfdownloadState extends State<Pdfdownload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Create PDF'),
          onPressed: _createPDF,
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString('Welcome to PDF Succinctly!',
        PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawImage(
        PdfBitmap(await _readImageData('Pdf_Succinctly.jpg')),
        Rect.fromLTWH(0, 100, 440, 550));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Roll No';
    header.cells[1].value = 'Name';
    header.cells[2].value = 'Class';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'Ramesh';
    row.cells[2].value = '7';

    row = grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = 'sathish';
    row.cells[2].value = '9';

    row = grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = 'fazul';
    row.cells[2].value = '10';

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
