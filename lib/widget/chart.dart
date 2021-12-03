import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// For homepage bar
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

List<Color> gradientColors = [primary];

LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.1,
          );
        }),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return '1';
            case 5:
              return '11';
            case 8:
              return '21';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '10k';
            case 3:
              return '50k';
            case 5:
              return '100k';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],
        isCurved: true,
        colors: gradientColors,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}

class SpendingBar extends StatefulWidget {
  SpendingBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SpendingBarState createState() => _SpendingBarState();
}

class _SpendingBarState extends State<SpendingBar> {
  late List<BarData> _Data;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _Data = getData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(text: "yes"),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          BarSeries<BarData, String>(
              name: 'GDP',
              dataSource: _Data,
              xValueMapper: (BarData gdp, _) => gdp.day,
              yValueMapper: (BarData gdp, _) => gdp.amount,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
        primaryXAxis: CategoryAxis(),
        // primaryYAxis: NumericAxis(
        //     edgeLabelPlacement: EdgeLabelPlacement.shift,
        //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
        //     title: AxisTitle(text: 'GDP in billions of U.S. Dollars')),
      ),
    ));
  }

  List<BarData> getData() {
    final List<BarData> Data = [
      BarData('Mon', 1600),
      BarData('Tue', 2490),
      BarData('Wed', 2900),
      BarData('Thu', 23050),
      BarData('Fri', 24880),
      BarData('Sat', 34390),
      BarData('Sun', 34390)
    ];
    return Data;
  }
}

class BarData {
  BarData(this.day, this.amount);
  final String day;
  final double amount;
}
