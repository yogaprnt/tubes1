import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrafikScrenn extends StatefulWidget {
  const GrafikScrenn({Key? key}) : super(key: key);

  @override
  State<GrafikScrenn> createState() => _GrafikScrennState();
}

class _GrafikScrennState extends State<GrafikScrenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        width: 400,
        child: LineChart(
          LineChartData(
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
                  FlSpot(6.8, 2.5),
                  FlSpot(8, 4),
                  FlSpot(9.5, 3),
                  FlSpot(11, 4),
                ],
                isCurved: true,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
              ),
            ],
            titlesData: FlTitlesData(),
            borderData: FlBorderData(show: true),
            gridData: FlGridData(show: true),
          ),
        ),
      ),
    );
  }
}
