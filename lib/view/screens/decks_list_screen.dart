import 'package:flutter/material.dart';
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';

class DecksListScreen extends StatefulWidget {
  final MainNavigationScreenState parent;

  const DecksListScreen({super.key, required this.parent});

  @override
  State<StatefulWidget> createState() => _DecksListScreenState();
}

class _DecksListScreenState extends State<DecksListScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search your Decks'),
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

  @override
  bool get wantKeepAlive => true;
}
