import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/view/screens/deck_list_options_screen.dart';
import 'package:placeholder_name/view_model/deck_list_options_view_model.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:provider/provider.dart';

class DeckPreviewCard extends StatefulWidget {
  final Function selected;
  final Deck deck;

  const DeckPreviewCard(
      {super.key, required this.selected, required this.deck});

  @override
  State<DeckPreviewCard> createState() => _DeckPreviewCardState();
}

class _DeckPreviewCardState extends State<DeckPreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Provider.of<DeckViewModel>(context, listen: true).selectedDeck ==
              widget.deck
          ? Colors.white60
          : Colors.white,
      borderOnForeground: true,
      shape: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () {
            widget.selected(widget.deck);
          },
          onLongPress: () {
            widget.selected(widget.deck);
            Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) =>
                        DeckListOptionScreen(deck: widget.deck)));
          },
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Image.network(widget.deck.image, height: 110),
                )),
            const Spacer(flex: 100),
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    kDebugMode ? Text("${widget.deck.id}") : Container(),
                    Text(widget.deck.format.name,
                        style: const TextStyle(fontSize: 15)),
                    Text(widget.deck.name,
                        style: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        if (widget.deck.isWhite)
                          SizedBox(
                            width: 25.0,
                            child: Image.asset(MTGColors.white.imageAssetPath,
                                height: 20.0),
                          ),
                        if (widget.deck.isBlue)
                          SizedBox(
                            width: 25.0,
                            child: Image.asset(MTGColors.blue.imageAssetPath,
                                height: 20.0),
                          ),
                        if (widget.deck.isBlack)
                          SizedBox(
                            width: 25.0,
                            child: Image.asset(MTGColors.black.imageAssetPath,
                                height: 20.0),
                          ),
                        if (widget.deck.isRed)
                          SizedBox(
                            width: 25.0,
                            child: Image.asset(MTGColors.red.imageAssetPath,
                                height: 20.0),
                          ),
                        if (widget.deck.isGreen)
                          SizedBox(
                            width: 25.0,
                            child: Image.asset(MTGColors.green.imageAssetPath,
                                height: 20.0),
                          ),
                      ],
                    )
                  ],
                ))
          ])),
    );
  }
}
