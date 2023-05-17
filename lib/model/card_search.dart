import 'card.dart';

class CardSearch {
  final List<MTGCard> cards;

  const CardSearch({required this.cards});

  factory CardSearch.fromJson(Map<String, dynamic> json) {
    List<MTGCard> cards = [];
    if (json['data'] != null) {
      for (var element in json['data']) {
        cards.add(MTGCard.fromJson(element));
      }
    }

    return CardSearch(cards: cards);
  }
}