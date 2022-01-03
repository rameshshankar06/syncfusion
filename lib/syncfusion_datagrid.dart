import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class datagrid extends StatefulWidget {
  const datagrid({Key key}) : super(key: key);

  @override
  _datagridState createState() => _datagridState();
}

class _datagridState extends State<datagrid> {
  List<Employee> _employees;
  EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfDataGridTheme(
            data: SfDataGridThemeData(headerColor: const Color(0xff64b5f6)),
            child: SfDataGrid(
                source: _employeeDataSource,
                columnWidthMode: ColumnWidthMode.fill,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'id',
                      label: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Text(
                            'ID',
                          ))),
                  GridColumn(
                      columnName: 'name',
                      label: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text('Name'))),
                  GridColumn(
                      columnName: 'designation',
                      label: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Designation',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'salary',
                      label: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text('Salary'))),
                ])));
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'Ramesh', 'Developer', 20000),
      Employee(10002, 'sathish', 'Developer', 30000),
      Employee(10003, 'fazul', 'Developer', 40000),
      Employee(10004, 'Michael', 'Designer', 12000),
      Employee(10005, 'Martin', 'Developer', 15000),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows;
  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}
