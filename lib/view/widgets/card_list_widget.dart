import 'package:flutter/material.dart';
import 'package:placeholder_name/model/card.dart' as api;

class CardListWidget extends StatefulWidget {
  final List<api.Card> _cardList;
  final Function _function;

  const CardListWidget(this._cardList, this._function, {super.key});

  @override
  CardListWidgetState createState() => CardListWidgetState();
}

class CardListWidgetState extends State<CardListWidget> {
  Widget _buildCardItem(api.Card card) {
    //api.Card? _selectedCard = Provider.of<CardViewModel>(context).card;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
      child: Center(
        child: Image.network(
            card.imageURIS?.png ?? card.cardFaces.first.imageURIS!.png,
            scale: 1.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget._cardList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            api.Card data = widget._cardList[index];
            return InkWell(
              onTap: () {
                widget._function(data);
              },
              child: _buildCardItem(data),
            );
          },
        ),
      ]),
    );
  }
}
