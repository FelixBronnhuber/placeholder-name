import 'card.dart';

class Deck {
  int id;
  String name;
  DeckFormat format;
  List<Card> cards;

  Deck(
      {required this.id,
      required this.name,
      required this.format,
      required this.cards});

  factory Deck.fromJson(Map<String, dynamic> json) {
    List<Card> cards = [];

    for (var card in json['cards']) {
      cards.add(Card.fromJson(card));
    }

    return Deck(
      id: json['id'],
      name: json['name'],
      format: DeckFormat.values
          .firstWhere((deckFormat) => (deckFormat.name == json['format'])),
      cards: cards,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['name'] = name;
    data['format'] = format.name;
    data['cards'] = cards.map((Card card) => card.toJson()).toList();

    return data;
  }
}

enum DeckFormat {
  commander(name: "Commander"),
  pauper(name: "Pauper");

  const DeckFormat({required this.name});

  final String name;
}
