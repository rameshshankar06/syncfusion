import 'package:flutter/material.dart';

import 'package:syncfusion/pdf_download/syncfusion_pdfdownload.dart';
import 'package:syncfusion/syncfusion_barchart.dart';
import 'package:syncfusion/syncfusion_datagrid.dart';
import 'package:syncfusion/syncfusion_datagrid_json.dart';
import 'package:syncfusion/syncfusion_datepicker.dart';
import 'package:syncfusion/syncfusion_excel.dart';
import 'package:syncfusion/syncfusion_flutter_excel/syncfusion_excel.dart';

import 'package:syncfusion/syncfusion_linechart.dart';
import 'package:syncfusion/syncfusion_map.dart';
import 'package:syncfusion/syncfusion_treemap.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            // Container(height: 300, child: datepicker()),
            Container(height: 300, child: linechart()),
            Container(height: 300, child: Barchart()),
            //Container(height: 300, child: datagrid()),
            //  Container(height: 500, child: Map()),
            // Container(height: 300, child: Treemap()),
            // Container(height: 100, child: Pdfdownload()),
            // Container(height: 100, child: Excel()),
            Container(height: 600, child: DatagridJson()),
            // Container(height: 300, child: Exceltable()),
          ],
        ),
      ),
    );
  }
}
