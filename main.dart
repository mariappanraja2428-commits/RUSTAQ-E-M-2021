import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/landing_page.dart';
import 'providers/records_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RecordsProvider(),
      child: const NamaRustaqApp(),
    ),
  );
}

class NamaRustaqApp extends StatelessWidget {
  const NamaRustaqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NAMA Rustaq',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
