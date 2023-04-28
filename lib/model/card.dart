class Card {
  final String id;
  final String uri;
  final String name;
  final String power;
  final String toughness;
  final String frame;
  final ImageURIS? imageURIS;
  final List<CardFace> cardFaces;

  const Card(
      {required this.id,
      required this.uri,
      required this.name,
      required this.power,
      required this.toughness,
      required this.frame,
      required this.imageURIS,
      required this.cardFaces});

  factory Card.fromJson(Map<String, dynamic> json) {
    ImageURIS? imageURIS;
    if (json['image_uris'] != null) {
      imageURIS = ImageURIS.fromJson(json['image_uris']);
    }

    List<CardFace> cardFaces = [];
    if (json['card_faces'] != null) {
      for (var element in json['card_faces']) {
        cardFaces.add(CardFace.fromJson(element));
      }
    }

    return Card(
        id: json['id'].toString(),
        uri: json['uri'].toString(),
        name: json['name'].toString(),
        power: json['power'].toString(),
        toughness: json['toughness'].toString(),
        frame: json['frame'].toString(),
        imageURIS: imageURIS,
        cardFaces: cardFaces);
  }
}

class CardFace {
  final String layout;
  final ImageURIS? imageURIS;

  const CardFace({required this.layout, required this.imageURIS});

  factory CardFace.fromJson(Map<String, dynamic> json) {
    ImageURIS? imageURIS;
    if (json['image_uris'] != null) {
      imageURIS = ImageURIS.fromJson(json['image_uris']);
    }

    return CardFace(
        layout: json['layout'].toString(),
        imageURIS: imageURIS);
  }
}

class CardSearch {
  final List<Card> cards;

  const CardSearch({required this.cards});

  factory CardSearch.fromJson(Map<String, dynamic> json) {
    List<Card> cards = [];
    if (json['data'] != null) {
      for (var element in json['data']) {
        //try {
          cards.add(Card.fromJson(element));
        //} catch(e) {};
      }
    }

    return CardSearch(cards: cards);
  }
}

class ImageURIS {
  final String png;
  final String borderCrop;
  final String artCrop;
  final String large;
  final String normal;
  final String small;

  const ImageURIS(
      {required this.png,
      required this.borderCrop,
      required this.artCrop,
      required this.large,
      required this.normal,
      required this.small});

  factory ImageURIS.fromJson(Map<String, dynamic> json) {
    return ImageURIS(
        png: json['png'],
        borderCrop: json['border_crop'],
        artCrop: json['art_crop'],
        large: json['large'],
        normal: json['normal'],
        small: json['small']);
  }
}
