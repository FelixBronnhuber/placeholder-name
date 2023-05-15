import 'package:flutter/material.dart';
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:provider/provider.dart';

class DeckStatisticsScreen extends StatefulWidget {
  final MainNavigationScreenState parent;

  const DeckStatisticsScreen({super.key, required this.parent});

  @override
  State<StatefulWidget> createState() => _DeckStatisticsScreenState();
}

class _DeckStatisticsScreenState extends State<DeckStatisticsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    int numberOfCards = Provider.of<DeckViewModel>(context, listen: true)
            .selectedDeck
            ?.cards
            .length ??
        0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck Statistics'),
        backgroundColor: const Color(0x00FFFFFF),
        elevation: 0.0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),
      ),
      body: Center(child: Text("Number of Cards in the deck: $numberOfCards")),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
