import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';
import 'package:placeholder_name/view_model/deck_list_options_view_model.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:placeholder_name/view/widgets/card_list_widget.dart';
import 'package:provider/provider.dart';

class DeckViewScreen extends StatefulWidget {
  final MainNavigationScreenState parent;

  const DeckViewScreen({super.key, required this.parent});

  @override
  State<StatefulWidget> createState() => _DeckViewScreenState();
}

class _DeckViewScreenState extends State<DeckViewScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    Deck? deck = Provider.of<DeckViewModel>(context, listen: true).selectedDeck;

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _styledFloatingButton(context),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    deck == null ? "No deck selected." : deck.name,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _handleDeckList(context, deck)),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Search your Deck'),
      backgroundColor: const Color(0x00FFFFFF),
      elevation: 0.0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
      ),
    );
  }

  Widget _styledFloatingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(icon: const Icon(Icons.add), onPressed: (){
        Deck? deck = Provider.of<DeckViewModel>(context, listen: false).selectedDeck;
        Provider.of<DeckViewModel>(context, listen: false).removeCardsFromSelectedDeck();
        Provider.of<DeckListOptionsViewModel>(context, listen: false).saveDeck(deck);
      }
      ),
    );
  }

  Widget _handleDeckList(BuildContext context, Deck? deck) {
    List<api.MTGCard> cards = deck?.cards ?? <api.MTGCard>[];
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CardListWidget(cards, "DeckViewModel"),
          ),
        ]
    );
  }

  @override
  bool get wantKeepAlive => true;
}
