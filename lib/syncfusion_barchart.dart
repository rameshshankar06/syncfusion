import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Barchart extends StatefulWidget {
  const Barchart({Key key}) : super(key: key);

  @override
  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  List<GDPData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(text: 'Continent wise GDP - 2021'),
        legend: Legend(isVisible: false),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          BarSeries<GDPData, String>(
              name: 'GDP',
              dataSource: _chartData,
              xValueMapper: (GDPData gdp, _) => gdp.continent,
              yValueMapper: (GDPData gdp, _) => gdp.gdp,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
            title: AxisTitle(text: 'GDP in billions of U.S. Dollars')),
      ),
    ));
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 1600),
      GDPData('Africa', 2490),
      GDPData('S America', 2900),
      GDPData('Europe', 23050),
      GDPData('N America', 24880),
      GDPData('Asia', 34390),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}
