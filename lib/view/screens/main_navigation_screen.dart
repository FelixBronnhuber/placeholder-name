import 'package:flutter/material.dart';
import 'package:placeholder_name/view/screens/card_search_screen.dart';
import 'package:placeholder_name/view/screens/deck_statistics_screen.dart';
import 'package:placeholder_name/view/screens/deck_view_screen.dart';
import 'package:placeholder_name/view/screens/decks_list_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<StatefulWidget> createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentScreen = 1;

  late PageController _controller;
  late DecksListScreen decksListScreen;
  late CardSearchScreen cardSearchScreen;
  late DeckViewScreen deckViewScreen;
  late DeckStatisticsScreen deckStatisticsScreen;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: _currentScreen,
      viewportFraction: 1.0,
    );

    decksListScreen = DecksListScreen(parent: this);
    cardSearchScreen = CardSearchScreen(parent: this);
    deckViewScreen = DeckViewScreen(parent: this);
    deckStatisticsScreen = DeckStatisticsScreen(parent: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      children: [
        Container(color: Colors.black),
        decksListScreen,
        cardSearchScreen,
        deckViewScreen,
        deckStatisticsScreen,
        Container(color: Colors.black)
      ],
      onPageChanged: (nextPage) {
        if (nextPage == 0) {
          _controller.animateToPage(4,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        } else if (nextPage == 5) {
          _controller.animateToPage(1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }

        setState(() {
          _currentScreen = nextPage;
        });
      },
    );
  }
}
