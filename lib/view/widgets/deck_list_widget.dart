import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/view/widgets/deck_preview_card.dart';

class DeckListWidget extends StatefulWidget {
  final List<Deck> _deckList;
  final Function _function;

  final Function _selected;

  const DeckListWidget(this._deckList, this._function, this._selected,
      {super.key});

  @override
  DeckListWidgetState createState() => DeckListWidgetState();
}

class DeckListWidgetState extends State<DeckListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 65.0, horizontal: 10.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget._deckList.length,
          itemBuilder: (BuildContext context, int index) {
            Deck deck = widget._deckList[index];
            return DeckPreviewCard(
              selected: widget._selected,
              deck: deck,
            );
          }),
    ));
  }
}
