import 'card.dart';

class Deck {
  int id;
  String name;
  DeckFormat format;
  List<MTGCard> cards;
  String image;

  Deck(
      {required this.id,
      required this.name,
      required this.format,
      required this.cards,
      required this.image});

  factory Deck.fromJson(Map<String, dynamic> json) {
    List<MTGCard> cards = [];

    for (var card in json['cards']) {
      cards.add(MTGCard.fromJson(card));
    }

    return Deck(
      id: json['id'],
      name: json['name'],
      format: DeckFormat.values
          .firstWhere((deckFormat) => (deckFormat.name == json['format'])),
      cards: cards,
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['name'] = name;
    data['format'] = format.name;
    data['cards'] = cards.map((MTGCard card) => card.toJson()).toList();
    data['image'] = image;

    return data;
  }
}

enum DeckFormat {
  commander(name: "Commander"),
  modern(name: "Modern"),
  pauper(name: "Pauper"),
  standard(name: "Standard"),
  conspiracy(name: "Conspiracy"),
  brawl(name: "Brawl"),
  boosterDraft(name: "Booster Draft"),
  planechase(name: "Planechase"),
  oathbreaker(name: "Oathbraker"),
  historic(name: "Historic"),
  vintage(name: "Vintage"),
  twoHeadedGiant(name: "Two-Headed Giant"),
  freeform(name: "Freeform");

  const DeckFormat({required this.name});

  final String name;
}
