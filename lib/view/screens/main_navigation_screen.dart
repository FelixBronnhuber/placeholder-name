import 'package:flutter/cupertino.dart';
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
  final _controller = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );

  late DecksListScreen decksListScreen;
  late CardSearchScreen cardSearchScreen;
  late DeckViewScreen deckViewScreen;
  late DeckStatisticsScreen deckStatisticsScreen;

  @override
  void initState() {
    super.initState();

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
        decksListScreen,
        cardSearchScreen,
        deckViewScreen,
        deckStatisticsScreen
      ],
    );
  }
}
