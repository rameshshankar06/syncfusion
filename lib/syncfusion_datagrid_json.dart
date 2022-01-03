import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class DatagridJson extends StatefulWidget {
  const DatagridJson({Key key}) : super(key: key);

  @override
  _DatagridJsonState createState() => _DatagridJsonState();
}

class _DatagridJsonState extends State<DatagridJson> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: getProductDataSource(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? SfDataGrid(source: snapshot.data, columns: getColumns())
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
        },
      ),
    ));
  }

  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await generateProductList();
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridTextColumn(
          columnName: 'orderID',
          width: 70,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text('Order ID',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'customerID',
          width: 100,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Text('Customer ID',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'employeeID',
          width: 100,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text('Employee ID',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'orderDate',
          width: 95,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Text('Order Date',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridTextColumn(
          columnName: 'freight',
          width: 65,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text('Freight')))
    ];
  }

  Future<List<Product>> generateProductList() async {
    var response = await http.get(Uri.parse(
        'https://ej2services.syncfusion.com/production/web-services/api/Orders'));
    var decodedProducts =
        json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> productList = await decodedProducts
        .map<Product>((json) => Product.fromJson(json))
        .toList();
    return productList;
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  List<DataGridRow> dataGridRows;
  List<Product> productList;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          DateFormat('MM/dd/yyyy').format(row.getCells()[3].value).toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[4].value.toStringAsFixed(1),
            overflow: TextOverflow.ellipsis,
          ))
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'orderID', value: dataGridRow.orderID),
        DataGridCell<String>(
            columnName: 'customerID', value: dataGridRow.customerID),
        DataGridCell<int>(
            columnName: 'employeeID', value: dataGridRow.employeeID),
        DataGridCell<DateTime>(
            columnName: 'orderDate', value: dataGridRow.orderDate),
        DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight)
      ]);
    }).toList(growable: false);
  }
}

class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        orderID: json['OrderID'],
        customerID: json['CustomerID'],
        employeeID: json['EmployeeID'],
        orderDate: DateTime.parse(json['OrderDate']),
        shippedDate: DateTime.parse(json['ShippedDate']),
        freight: json['Freight'],
        shipName: json['ShipName'],
        shipAddress: json['ShipAddress'],
        shipCity: json['ShipCity'],
        shipPostelCode: json['ShipPostelCode'],
        shipCountry: json['ShipCountry']);
  }
  Product(
      {this.orderID,
      this.customerID,
      this.employeeID,
      this.orderDate,
      this.shippedDate,
      this.freight,
      this.shipName,
      this.shipAddress,
      this.shipCity,
      this.shipPostelCode,
      this.shipCountry});
  final int orderID;
  final String customerID;
  final int employeeID;
  final DateTime orderDate;
  final DateTime shippedDate;
  final double freight;
  final String shipName;
  final String shipAddress;
  final String shipCity;
  final int shipPostelCode;
  final String shipCountry;
}
