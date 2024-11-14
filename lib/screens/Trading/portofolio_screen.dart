import 'package:flutter/material.dart';
import 'package:imitahe3/screens/Trading/asset_screen.dart';
import 'package:imitahe3/screens/Trading/portofolio.dart';


class PortfolioScreen extends StatelessWidget {
  final Portfolio portfolio;
  final List<Asset> assets;

  PortfolioScreen({required this.portfolio, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Portfolio")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Cash Balance"),
            trailing: Text("\$${portfolio.cashBalance.toStringAsFixed(2)}"),
          ),
          Expanded(
            child: ListView(
              children: portfolio.holdings.entries.map((entry) {
                final asset = assets.firstWhere(
                    (a) => a.symbol == entry.key,
                    orElse: () => Asset(name: entry.key, symbol: entry.key, price: 0));
                return ListTile(
                  title: Text(asset.name),
                  subtitle: Text("${entry.value} units"),
                  trailing: Text("\$${(asset.price * entry.value).toStringAsFixed(2)}"),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text("Total Portfolio Value"),
            trailing: Text("\$${portfolio.getPortfolioValue(assets).toStringAsFixed(2)}"),
          ),
        ],
      ),
    );
  }
}
