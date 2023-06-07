import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/view/widgets/deck_preview_card.dart';
import 'package:placeholder_name/view_model/deck_list_options_view_model.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:provider/provider.dart';

class DeckListWidget extends StatelessWidget {
  const DeckListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeckListOptionsViewModel>(builder: (context, vm, child) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 65.0, horizontal: 10.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: vm.decks.length,
            itemBuilder: (BuildContext context, int index) {
              Deck deck = vm.decks[index];
              return DeckPreviewCard(
                selected: (Deck deck) {
                  Provider.of<DeckViewModel>(context, listen: false)
                      .selectedDeck = deck;
                },
                deck: deck,
              );
            }),
      ));
    });
  }
}
