import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:forex_conversion/forex_conversion.dart';

class BifUsdChartPage extends StatefulWidget {
  @override
  _BifUsdChartPageState createState() => _BifUsdChartPageState();
}

class _BifUsdChartPageState extends State<BifUsdChartPage> {
  final fx = Forex(); // Initialize Forex instance
  List<FlSpot> _dataPoints = [];
  double _timeCounter = 0;
  double? _currentExchangeRate;
  double _priceChange = 0.0;
  Timer? _timer;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchExchangeRate();
    // Update exchange rate every 30 seconds
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      _fetchExchangeRate();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchExchangeRate() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Using the correct syntax with named parameters
      double rate = await fx.getCurrencyConverted(
        sourceCurrency: 'BIF',
        destinationCurrency: 'USD',
        sourceAmount: 1,
      );

      if (!mounted) return;

      setState(() {
        _currentExchangeRate = rate;
        _timeCounter += 1;
        if (_dataPoints.isNotEmpty) {
          _priceChange = rate - _dataPoints.last.y;
        }
        _dataPoints.add(FlSpot(_timeCounter, rate));

        // Keep only the latest 20 points for readability
        if (_dataPoints.length > 20) {
          _dataPoints.removeAt(0);
        }
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _errorMessage = "Failed to fetch exchange rate. Please try again later.";
        _isLoading = false;
      });
      print("Error fetching BIF to USD rate: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('BIF to USD Real-Time Chart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchExchangeRate,
          ),
        ],
      ),
      body: _errorMessage != null
          ? _buildErrorView()
          : Padding(
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

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _errorMessage ?? '',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchExchangeRate,
            child: const Text('Retry'),
          ),
        ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoBox(
            label: "Current Rate",
            value: _isLoading
                ? 'Loading...'
                : _currentExchangeRate != null
                    ? '\$${_currentExchangeRate!.toStringAsFixed(5)}'
                    : 'N/A',
            color: Colors.blue,
          ),
          _buildInfoBox(
            label: "Variation",
            value: _isLoading
                ? 'Loading...'
                : _priceChange != 0
                    ? (_priceChange > 0
                        ? '+${_priceChange.toStringAsFixed(5)}'
                        : _priceChange.toStringAsFixed(5))
                    : '0.0',
            color: _priceChange >= 0 ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({required String label, required String value, required Color color}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection() {
    if (_isLoading && _dataPoints.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
              dotData: FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '\$${value.toStringAsFixed(5)}',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
