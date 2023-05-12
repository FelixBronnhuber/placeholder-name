import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';

class DeckListWidget extends StatefulWidget {
  final List<Deck> _deckList;
  final Function _function;

  const DeckListWidget(this._deckList, this._function, {super.key});

  @override
  DeckListWidgetState createState() => DeckListWidgetState();
}

class DeckListWidgetState extends State<DeckListWidget> {
  Widget _buildDeckItem(Deck deck) {
    return Card(
      borderOnForeground: true,
      shape: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () {
            widget._function(deck);
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
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
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
