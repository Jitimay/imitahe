

import 'package:imitahe3/screens/Trading/asset_screen.dart';
import 'package:imitahe3/screens/Trading/portofolio.dart';

class TradeSimulator {
  final Portfolio portfolio;

  TradeSimulator(this.portfolio);

  // Executes a buy action without checking for funds
  String buyAsset(Asset asset, double quantity) {
    double totalCost = asset.price * quantity;
    portfolio.cashBalance -= totalCost;
    portfolio.holdings[asset.symbol] =
        (portfolio.holdings[asset.symbol] ?? 0) + quantity;
    return "Purchased $quantity of ${asset.name} for \$$totalCost";
  }

  // Executes a sell action without checking for sufficient holdings
  String sellAsset(Asset asset, double quantity) {
    double totalSale = asset.price * quantity;
    portfolio.cashBalance += totalSale;
    portfolio.holdings[asset.symbol] =
        (portfolio.holdings[asset.symbol] ?? 0) - quantity;

    // Remove asset if quantity becomes zero or less
    if (portfolio.holdings[asset.symbol]! <= 0) {
      portfolio.holdings.remove(asset.symbol);
    }
    return "Sold $quantity of ${asset.name} for \$$totalSale";
  }
}
