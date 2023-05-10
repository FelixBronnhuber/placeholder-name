import 'package:flutter/material.dart';
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';

class DeckStatisticsScreen extends StatefulWidget {
  final MainNavigationScreenState parent;

  const DeckStatisticsScreen({super.key, required this.parent});

  @override
  State<StatefulWidget> createState() => _DeckStatisticsScreenState();
}

class _DeckStatisticsScreenState extends State<DeckStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck Statistics'),
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0.0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),
      ),
      body: const Center(child: Text("...")),
    );
  }
}
