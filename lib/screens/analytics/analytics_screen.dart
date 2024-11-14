import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildPriceInfo(),
            const SizedBox(height: 16),
            _buildChart(),
            const SizedBox(height: 16),
            _buildTimeRangeButtons(),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'LTC',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.show_chart, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '\$72.76',
          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              '-\$6.69',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            Text(
              '-9.2%',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _getChartSpots(),
              isCurved: true,
              color: Colors.orange,
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.orange.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getChartSpots() {
    return [
      const FlSpot(0, 83.26),
      const FlSpot(1, 82.5),
      const FlSpot(2, 81.0),
      const FlSpot(3, 80.5),
      const FlSpot(4, 79.2),
      const FlSpot(5, 73.78),
      const FlSpot(6, 72.0),
      const FlSpot(7, 71.0),
      const FlSpot(8, 72.76),
      const FlSpot(9, 70.29),
    ];
  }

  Widget _buildTimeRangeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _TimeRangeButton(label: 'D'),
        _TimeRangeButton(label: 'W'),
        _TimeRangeButton(label: 'M'),
        _TimeRangeButton(label: '6M'),
        _TimeRangeButton(label: 'Y'),
        _TimeRangeButton(label: 'All'),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            minimumSize: const Size(150, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Buy', style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            minimumSize: const Size(150, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Sell', style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ],
    );
  }
}

class _TimeRangeButton extends StatelessWidget {
  final String label;

  const _TimeRangeButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
