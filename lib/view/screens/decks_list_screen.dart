import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/model/responses/response.dart';
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';
import 'package:placeholder_name/view/widgets/deck_list_widget.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:provider/provider.dart';

class DecksListScreen extends StatefulWidget {
  final MainNavigationScreenState parent;

  const DecksListScreen({super.key, required this.parent});

  @override
  State<StatefulWidget> createState() => _DecksListScreenState();
}

class _DecksListScreenState extends State<DecksListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => executeAfterBuild(context));

    super.build(context);

    Response deckResponse = Provider.of<DeckViewModel>(context).response;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search your Decks'),
        backgroundColor: const Color(0x00FFFFFF),
        elevation: 0.0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),
      ),
      floatingActionButton: _styledFloatingButton(context),
      body: Column(children: <Widget>[
        Container(child: _handleDeckResponse(context, deckResponse))
      ]),
    );
  }

  Widget _styledFloatingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(icon: const Icon(Icons.add), onPressed: () {

      }),
    );
  }

  Widget _handleDeckResponse(BuildContext context, Response deckResponse) {
    List<Deck>? deckList = deckResponse.data as List<Deck>?;

    switch (deckResponse.status) {
      case Status.initial:
        return const Center(child: Text("init"));
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Expanded(
            child: DeckListWidget(deckList!, (Deck deck) {
          Provider.of<DeckViewModel>(context, listen: false);
        }, updateDeckSelection));
      case Status.error:
        return const Center(
          child: Text('An unexpected error occurred while loading your decks.'),
        );
    }
  }

  void updateDeckSelection(Deck deck) {
    Provider.of<DeckViewModel>(context, listen: false).selectedDeck = deck;
  }

  void executeAfterBuild(BuildContext context) {
    Provider.of<DeckViewModel>(context, listen: false).fetchDeckData();
  }

  @override
  bool get wantKeepAlive => true;
}
