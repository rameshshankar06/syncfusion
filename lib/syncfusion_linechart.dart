import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class linechart extends StatefulWidget {
  const linechart({Key key}) : super(key: key);

  @override
  _linechartState createState() => _linechartState();
}

class _linechartState extends State<linechart> {
  List<SalesData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Yearly sales analysis'),
      legend: Legend(isVisible: false),
      tooltipBehavior: _tooltipBehavior,
      series: <SplineSeries>[
        SplineSeries<SalesData, double>(
            name: 'Sales',
            dataSource: _chartData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            color: Colors.blue,
            width: 4,
            splineType: SplineType.cardinal,
            cardinalSplineTension: 0.9)
      ],
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}M',
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30),
      SalesData(2022, 12),
      SalesData(2023, 24),
      SalesData(2024, 18),
      SalesData(2025, 30),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
