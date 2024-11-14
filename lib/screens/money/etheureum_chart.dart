// ethereum_chart.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EthereumChartPage extends StatefulWidget {
  @override
  _EthereumChartPageState createState() => _EthereumChartPageState();
}

class _EthereumChartPageState extends State<EthereumChartPage> {
  final WebSocketChannel _channel = IOWebSocketChannel.connect(
    Uri.parse("wss://stream.binance.com:9443/ws/ethusdt@trade"),
  );

  List<FlSpot> _dataPoints = [];
  double _timeCounter = 0;
  double? _currentPrice;
  double _volume = 0.0;
  double _priceChange = 0.0;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _channel.stream.listen((message) {
      final data = jsonDecode(message);
      final price = double.parse(data['p']);
      final volume = double.parse(data['q']); // Get volume for this trade

      setState(() {
        _timeCounter += 1;
        _currentPrice = price;
        _volume += volume; // Accumulate volume
        if (_dataPoints.isNotEmpty) {
          _priceChange = price - _dataPoints.last.y; // Calculate price variation
        }
        _dataPoints.add(FlSpot(_timeCounter, price));

        if (_dataPoints.length > 20) {
          _dataPoints.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Ethereum Real-Time Chart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTopSection(),
            const SizedBox(height: 20),
            Expanded(child: _buildChartSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoBox(
                label: "Price",
                value: _currentPrice != null ? '\$${_currentPrice!.toStringAsFixed(2)}' : 'Loading...',
                color: Colors.blue,
              ),
              _buildInfoBox(
                label: "24h Volume",
                value: '\$${_volume.toStringAsFixed(2)}',
                color: Colors.purple,
              ),
              _buildInfoBox(
                label: "Variation",
                value: _priceChange != null
                    ? (_priceChange > 0 ? '+${_priceChange.toStringAsFixed(2)}' : _priceChange.toStringAsFixed(2))
                    : '0.0',
                color: _priceChange >= 0 ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({required String label, required String value, required Color color}) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildChartSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: _dataPoints,
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.3),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text('\$${value.toStringAsFixed(0)}', style: TextStyle(color: Colors.white, fontSize: 10));
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (_) {
            return FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1);
          }),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
