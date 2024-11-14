import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Wallet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildBalanceCard(),
            const SizedBox(height: 20),
            _buildTransactionHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Total Balance', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('\$5,000.00', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Expanded(
      child: ListView(
        children: const [
          _TransactionItem(
            icon: LineIcons.bitcoin,
            title: 'Bitcoin',
            amount: '+0.1 BTC',
            date: '1 Nov 2024',
          ),
          _TransactionItem(
            icon: LineIcons.ethereum,
            title: 'Ethereum',
            amount: '+0.5 ETH',
            date: '30 Oct 2024',
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final String date;

  const _TransactionItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
      trailing: Text(amount, style: const TextStyle(color: Colors.green)),
    );
  }
}
