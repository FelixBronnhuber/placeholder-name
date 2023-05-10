import 'package:flutter/material.dart';
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';

class DeckViewScreen extends StatefulWidget {
  final MainNavigationScreenState parent;

  const DeckViewScreen({super.key, required this.parent});

  @override
  State<StatefulWidget> createState() => _DeckViewScreenState();
}

class _DeckViewScreenState extends State<DeckViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search your Deck'),
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
