import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; 
import 'package:imitahe3/screens/Auth/screens/auth_service.dart';
import 'package:imitahe3/screens/Auth/screens/login_with_google.dart';

import 'package:imitahe3/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotifications(); 
  await Firebase.initializeApp(); 
  WebViewPlatform.instance = WebViewPlatform.instance;
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        // Add other providers if needed
      ],
      child: MyApp(),
    ),
  );
}

void initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Crypto Portfolio',
            theme: theme,
            home:  LoginScreen(), // Set your initial screen
          );
        },
      ),
    );
  }
}
