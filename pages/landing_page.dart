import 'package:flutter/material.dart';
import '../widgets/area_button.dart';
import 'data_entry_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  final List<String> areas = const [
    'RUSTAQ EMERGENCY',
    'HAZAM EMERGENCY',
    'HOQAIN EMERGENCY',
    'KHAFDI EMERGENCY',
    'AWABI EMERGENCY',
    'RUSTAQ MAINTENANCES - 1',
    'HAZAM MAINTENANCES - 2',
    'RUSTAQ ASSET SECURITY - 1',
    'HAZAM ASSET SECURITY - 1'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/background_page1.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "NAMA ELECTRICITY DISTRIBUTION COMPANY RUSTAQ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/nama_logo.png', width: 150),
                  const SizedBox(height: 40),
                  ...areas.map((area) => AreaButton(
                        areaName: area,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DataEntryPage(area: area)));
                        },
                      )),
                  const SizedBox(height: 40),
                  Image.asset('assets/nama_curve_067c25a7-7f31-4e80-b49a-9ef4f4209ca1.png', width: 300),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
