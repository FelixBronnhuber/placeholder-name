import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
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

  Widget _handleDeckList(BuildContext context, Deck? deck) {
    List<api.MTGCard> cards = deck?.cards ?? <api.MTGCard>[];

    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) => _buildCardItem(cards[index]),
    );
  }

  Widget _buildCardItem(api.MTGCard card) {
    bool status = false;
    AnimationController controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    Animation<double> animation =
        Tween<double>(begin: 0, end: 1.571).animate(controller);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
      child: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animation.value,
              child: InkWell(
                onTap: () {
                  if (status) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                  status = !status;
                },
                child: Image.network(
                    card.imageURIS?.png ?? card.cardFaces.first.imageURIS!.png,
                    scale: 1.0),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
