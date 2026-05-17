import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'providers/worker_auth_provider.dart';

import 'screens/auth/worker_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WorkerAuthProvider())],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: "PA Worker",

        theme: ThemeData(primaryColor: const Color(0xFF6FE7DD)),

        home: const WorkerLoginScreen(),
      ),
    );
  }
}
