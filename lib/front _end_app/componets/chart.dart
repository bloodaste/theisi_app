import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 5,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(2, 3),
              FlSpot(4, 3),
              FlSpot(6, 4),
              FlSpot(8, 3),
              FlSpot(10, 0),
            ],
            isCurved: true,
            barWidth: 5,
            color: Colors.black,
          ),
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 3),
              FlSpot(3, 2),
              FlSpot(5, 4),
              FlSpot(7, 3),
              FlSpot(11, 2),
            ],
            isCurved: true,
            color: Colors.green,
            barWidth: 5,
          ),
        ]));
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  final Map<int, String> labels = {
    0: 'Jan',
    1: 'Feb',
    2: 'Mar',
    3: 'Apr',
    4: 'May',
    5: 'Jun',
    6: 'Jul',
    7: 'Aug',
    8: 'Sep',
    9: 'Oct',
    10: 'Nov',
    11: 'Dec',
  };

  final text = labels[value.toInt()] ?? '';

  return SideTitleWidget(
    meta: meta,
    space: 8,
    child: Text(text, style: style),
  );
}
