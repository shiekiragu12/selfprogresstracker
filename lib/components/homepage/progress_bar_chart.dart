import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressBarChart extends StatelessWidget {
  const ProgressBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 28),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 42,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          makeGroupData(0, 4),
          makeGroupData(1, 7),
          makeGroupData(2, 6),
          makeGroupData(3, 10),
          makeGroupData(4, 5),
        ],
        gridData: FlGridData(show: true),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 16,
          borderRadius: BorderRadius.circular(4),
          color: Colors.amber,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    String text = (value.toInt() >= 0 && value.toInt() < labels.length)
        ? labels[value.toInt()]
        : '';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }
}
