import 'package:e_store/features/welcome/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/model/user_provider.dart';
import 'features/auth/service/auth_service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: Consumer<AuthService>(
          builder: (context, auth, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'E-Store',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: const SplashScreen()),
        ));
  }
}
