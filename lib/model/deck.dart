import 'card.dart';

class Deck {
  int id;
  String name;
  DeckFormat format;
  List<MTGCard> cards;
  String image;
  bool isWhite;
  bool isBlue;
  bool isBlack;
  bool isRed;
  bool isGreen;

  Deck(
      {required this.id,
      required this.name,
      required this.format,
      required this.cards,
      required this.image,
      required this.isWhite,
      required this.isBlue,
      required this.isBlack,
      required this.isRed,
      required this.isGreen});

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
      image: json['image'],
      isWhite: json['isWhite'],
      isBlue: json['isBlue'],
      isBlack: json['isBlack'],
      isRed: json['isRed'],
      isGreen: json['isGreen'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['name'] = name;
    data['format'] = format.name;
    data['cards'] = cards.map((MTGCard card) => card.toJson()).toList();
    data['image'] = image;
    data['isWhite'] = isWhite;
    data['isBlue'] = isBlue;
    data['isBlack'] = isBlack;
    data['isRed'] = isRed;
    data['isGreen'] = isGreen;

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
