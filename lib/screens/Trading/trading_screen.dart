// trading_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:imitahe3/main.dart';
import 'package:imitahe3/screens/Trading/asset_screen.dart';
import 'package:imitahe3/screens/Trading/portofolio_screen.dart';
import 'package:imitahe3/screens/Trading/trade_similator.dart';


class TradingScreen extends StatefulWidget {
  final TradeSimulator tradeSimulator;

  const TradingScreen({Key? key, required this.tradeSimulator}) : super(key: key);

  @override
  _TradingScreenState createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
  List<Asset> assets = [
    Asset(name: 'Bitcoin', symbol: 'BTC', price: 50000),
    Asset(name: 'Ethereum', symbol: 'ETH', price: 3000),
    Asset(name: 'Ripple', symbol: 'XRP', price: 1),
  ];

  Future<void> showTransactionNotification(String message, double amount) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'transaction_channel_id', // channelId
    'Transactions', // channelName
    channelDescription: 'Transaction Notifications',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Transaction Confirmed',
    '$message: \$${amount.toStringAsFixed(2)}',
    platformChannelSpecifics,
  );
}


  void _showTradeDialog(Asset asset, bool isBuy) {
    final quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isBuy ? 'Buy ${asset.name}' : 'Sell ${asset.name}'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final quantity = double.tryParse(quantityController.text) ?? 0;
                final double amount = asset.price * quantity;

                final result = isBuy
                    ? widget.tradeSimulator.buyAsset(asset, quantity)
                    : widget.tradeSimulator.sellAsset(asset, quantity);

                Navigator.of(context).pop();
                showTransactionNotification(
                  isBuy ? 'Bought ${asset.name}' : 'Sold ${asset.name}',
                  amount,
                );

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(result)));
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Trading Simulator"),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_balance_wallet),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PortfolioScreen(
                  portfolio: widget.tradeSimulator.portfolio,
                  assets: assets,
                ),
              ),
            );
          },
        ),
      ],
    ),
    body: Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await showTransactionNotification('Test Transaction', 100);
          },
          child: Text("Test Notification"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: assets.length,
            itemBuilder: (context, index) {
              final asset = assets[index];
              return ListTile(
                title: Text(asset.name),
                subtitle: Text(asset.symbol),
                trailing: Text("\$${asset.price.toStringAsFixed(2)}"),
                onTap: () => _showTradeDialog(asset, true),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}