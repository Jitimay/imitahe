import 'package:flutter/material.dart';
import 'package:imitahe3/screens/Auth/screens/login_with_google.dart';
import 'package:imitahe3/screens/money/bitcoin_chart.dart';
import 'package:imitahe3/screens/money/etheureum_chart.dart';
import 'package:imitahe3/screens/money/bif_chart.dart'; // Import the BIF chart page
import 'package:imitahe3/screens/news/news_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildHeader(context), 
            const SizedBox(height: 20),
            _buildMainPortfolio(context),
            const SizedBox(height: 20),
            _buildFundsSection(context),
            const SizedBox(height: 20),
            _buildTabs(),
            _buildAssetsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _showLogoutDialog(context),
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('lib/assets/profile.jpg'),
            ),
          ),
          const SizedBox(width: 10), 
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, !',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'n.osborn@shakuro.com',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text("Log Out"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                ); // Navigate to LoginScreen
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainPortfolio(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsPage()),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'lib/assets/economic.jpg', 
          fit: BoxFit.cover,
          width: double.infinity,
          height: 150,
        ),
      ),
    );
  }

  Widget _buildFundsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('My Funds', style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the Bitcoin chart page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BitcoinChartPage()),
                  );
                },
                child: _buildCryptoCard('Bitcoin', 'BTC', '\$27,642.01', '+268.12'),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Navigate to the Ethereum chart page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EthereumChartPage()),
                  );
                },
                child: _buildCryptoCard('Ethereum', 'ETH', '\$1,666.36', '+16.36'),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Navigate to the BIF chart page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BifUsdChartPage()),
                  );
                },
                child: _buildCryptoCard('Burundian Franc', 'BIF', '0.0005 USD', '+0.0001'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCryptoCard(String name, String symbol, String value, String change) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 4),
          Text(symbol, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
          Text(change, style: TextStyle(color: change.startsWith('-') ? Colors.red : Colors.green)),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text('Most popular', style: TextStyle(color: Colors.orange)),
        Text('Biggest movers', style: TextStyle(color: Colors.white)),
        Text('Recommended', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildAssetsList() {
    return Expanded(
      child: ListView(
        children: const [
          _AssetItem(name: 'Polygon', symbol: 'MATIC', value: '\$0.51', change: '-0.02'),
          _AssetItem(name: 'Tether', symbol: 'USDT', value: '\$1', change: '+0.11'),
          _AssetItem(name: 'Chainlink', symbol: 'LINK', value: '\$7.72', change: '-0.05'),
        ],
      ),
    );
  }
}

class _AssetItem extends StatelessWidget {
  final String name;
  final String symbol;
  final String value;
  final String change;

  const _AssetItem({
    Key? key,
    required this.name,
    required this.symbol,
    required this.value,
    required this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[800],
        child: Text(symbol[0], style: const TextStyle(color: Colors.white)),
      ),
      title: Text(name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(symbol, style: const TextStyle(color: Colors.grey)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(color: Colors.white)),
          Text(change, style: TextStyle(color: change.startsWith('-') ? Colors.red : Colors.green)),
        ],
      ),
    );
  }
}
