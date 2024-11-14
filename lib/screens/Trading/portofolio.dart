// portfolio.dart
import 'package:imitahe3/screens/Trading/asset_screen.dart';

class Portfolio {
  double cashBalance;
  Map<String, double> holdings;

  Portfolio({this.cashBalance = 10000, this.holdings = const {}});

  // Calculates the total portfolio value based on asset prices
  double getPortfolioValue(List<Asset> assets) {
    double holdingsValue = 0.0;
    for (var asset in assets) {
      if (holdings.containsKey(asset.symbol)) {
        holdingsValue += holdings[asset.symbol]! * asset.price;
      }
    }
    return cashBalance + holdingsValue;
  }
}
