import 'card.dart';

class CardSearch {
  final List<Card> cards;

  const CardSearch({required this.cards});

  factory CardSearch.fromJson(Map<String, dynamic> json) {
    List<Card> cards = [];
    if (json['data'] != null) {
      for (var element in json['data']) {
        cards.add(Card.fromJson(element));
      }
    }

    return CardSearch(cards: cards);
  }
}