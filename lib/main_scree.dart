import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:imitahe3/screens/Home/home_screen.dart';
import 'package:imitahe3/screens/Trading/portofolio.dart';
import 'package:imitahe3/screens/Trading/trade_similator.dart';
import 'package:imitahe3/screens/Trading/trading_screen.dart';
import 'package:imitahe3/screens/setiings/settings_screen.dart';
import 'package:imitahe3/screens/wallet/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final Portfolio portfolio;
  late final TradeSimulator tradeSimulator;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    portfolio = Portfolio();
    tradeSimulator = TradeSimulator(portfolio); // Initialize trade simulator with portfolio

    // Initialize _screens with the tradeSimulator after it's available
    _screens = [
      const HomeScreen(key: PageStorageKey('HomeScreen')),
      const WalletScreen(key: PageStorageKey('WalletScreen')),
      TradingScreen(key: PageStorageKey('TradingScreen'), tradeSimulator: tradeSimulator),
      const SettingsScreen(key: PageStorageKey('SettingsScreen')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: GNav(
          backgroundColor: Colors.black,
          tabBackgroundColor: Colors.green,
          color: Colors.white,
          activeColor: Colors.white,
          gap: 8,
          padding: const EdgeInsets.all(12),
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.account_balance_wallet, text: 'Wallet'),
            GButton(icon: Icons.show_chart, text: 'Trading'), // Updated icon and label
            GButton(icon: Icons.settings, text: 'Settings'),
          ],
        ),
      ),
    );
  }
}
