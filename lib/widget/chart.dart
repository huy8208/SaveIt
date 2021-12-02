/*import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// For homepage bar chart
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
        // getTextStyles: (value) =>
        //     const TextStyle(color: Color(0xff68737d), fontSize: 12),
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
        // getTextStyles: (value) => const TextStyle(
        //   color: Color(0xff67727d),
        //   fontSize: 12,
        // ),
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

class SpendingBarChart extends StatefulWidget {
  SpendingBarChart({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SpendingBarChartState createState() => _SpendingBarChartState();
}

class _SpendingBarChartState extends State<SpendingBarChart> {
  late List<BarChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;

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
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          BarSeries<BarChartData, String>(
              name: 'GDP',
              dataSource: _chartData,
              xValueMapper: (BarChartData gdp, _) => gdp.day,
              yValueMapper: (BarChartData gdp, _) => gdp.amount,
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

  List<BarChartData> getChartData() {
    final List<BarChartData> chartData = [
      BarChartData('Mon', 1600),
      BarChartData('Tue', 2490),
      BarChartData('Wed', 2900),
      BarChartData('Thu', 23050),
      BarChartData('Fri', 24880),
      BarChartData('Sat', 34390),
      BarChartData('Sun', 34390)
    ];
    return chartData;
  }
}

class BarChartData {
  BarChartData(this.day, this.amount);
  final String day;
  final double amount;
}
*/