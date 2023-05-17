import 'package:flutter/material.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/view_model/card_view_model.dart';
import 'package:provider/provider.dart';

class CardListWidget extends StatefulWidget {
  final List<api.MTGCard> _cardList;
  final Function _function;

  const CardListWidget(this._cardList, this._function, {super.key});

  @override
  CardListWidgetState createState() => CardListWidgetState();
}

class CardListWidgetState extends State<CardListWidget>
    with TickerProviderStateMixin {
  Widget _buildCardItem(api.MTGCard card) {
    bool status = false;
    AnimationController controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    Animation<double> animation =
        Tween<double>(begin: 0, end: 1.571).animate(controller);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
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
                  Provider.of<CardViewModel>(context, listen: false).updateSelectedCards(card, status);
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget._cardList.length,
          itemBuilder: (BuildContext context, int index) {
            api.MTGCard data = widget._cardList[index];
            return InkWell(
              onTap: () {
                widget._function(data);
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildCardItem(data)),
            );
          },
        ),
      ]),
    );
  }
}
