import 'package:flutter/material.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/view_model/card_view_model.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:provider/provider.dart';

class CardListWidget extends StatefulWidget {
  final List<api.MTGCard> _cardList;
  final String _viewModel;

  const CardListWidget(this._cardList, this._viewModel, {super.key});

  @override
  CardListWidgetState createState() => CardListWidgetState();
}

class CardListWidgetState extends State<CardListWidget>
    with TickerProviderStateMixin {
  Widget _buildCardItem(api.MTGCard card, String viewModel) {
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
                  if (!status) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                  status = !status;
                  if(viewModel == "CardViewModel") {
                    Provider.of<CardViewModel>(context, listen: false)
                        .updateSelectedCards(card, status);
                  }
                  else if (viewModel == "DeckViewModel") {
                    Provider.of<DeckViewModel>(context, listen: false).updateSelectedCards(card, status);
                  }
                },
                child: FadeInImage(
                  fadeInDuration: const Duration(milliseconds: 2),
                  image: NetworkImage(
                      card.imageURIS?.png ??
                          card.cardFaces.first.imageURIS!.png,
                      scale: 1.0),
                  placeholder: const AssetImage("assets/card_back.jpg"),
                ),
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
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildCardItem(data, widget._viewModel)),
            );
          },
        ),
      ]),
    );
  }
}
