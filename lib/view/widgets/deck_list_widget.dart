import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:provider/provider.dart';

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
  Widget _buildDeckItem(Deck deck) {
    return Card(
      color:
          Provider.of<DeckViewModel>(context, listen: true).selectedDeck == deck
              ? Colors.white60
              : Colors.white,
      borderOnForeground: true,
      shape: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () {
            widget._selected(deck);
          },
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Image.network(deck.image, height: 110),
                )),
            const Spacer(flex: 100),
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(deck.format.name,
                        style: const TextStyle(fontSize: 15)),
                    Text(deck.name,
                        style: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic))
                  ],
                ))
          ])),
    );
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
            return _buildDeckItem(deck);
          }),
    ));
  }
}
