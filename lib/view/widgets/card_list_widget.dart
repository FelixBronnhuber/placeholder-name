import 'package:flutter/material.dart';
import 'package:placeholder_name/model/card.dart' as api;

class CardListWidget extends StatefulWidget {
  final List<api.Card> _cardList;
  final Function _function;

  const CardListWidget(this._cardList, this._function, {super.key});

  @override
  CardListWidgetState createState() => CardListWidgetState();
}

class CardListWidgetState extends State<CardListWidget> with TickerProviderStateMixin{

  Widget _buildCardItem(api.Card card) {
    bool status = false;
    AnimationController _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    Animation<double> _animation = Tween<double>(begin: 0, end: 1.571).animate(_controller);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
      child: Center(
          child:AnimatedBuilder(animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value,
                child: InkWell(
                  onTap: () {
                    if(status)
                      _controller.forward();
                    else
                      _controller.reverse();
                    status = !status;
                  },
                  child: Image.network(
                      card.imageURIS?.png ??
                          card.cardFaces.first.imageURIS!.png,
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
