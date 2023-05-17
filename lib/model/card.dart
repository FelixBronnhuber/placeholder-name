import 'card_face.dart';
import 'image_uris.dart';

class MTGCard {
  final String id;
  final String uri;
  final String name;
  final String power;
  final String toughness;
  final String frame;
  final ImageURIS? imageURIS;
  final List<CardFace> cardFaces;

  const MTGCard(
      {required this.id,
      required this.uri,
      required this.name,
      required this.power,
      required this.toughness,
      required this.frame,
      required this.imageURIS,
      required this.cardFaces});

  factory MTGCard.fromJson(Map<String, dynamic> json) {
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

    return MTGCard(
        id: json['id'].toString(),
        uri: json['uri'].toString(),
        name: json['name'].toString(),
        power: json['power'].toString(),
        toughness: json['toughness'].toString(),
        frame: json['frame'].toString(),
        imageURIS: imageURIS,
        cardFaces: cardFaces);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['uri'] = uri;
    data['name'] = name;
    data['power'] = power;
    data['toughness'] = toughness;
    data['frame'] = frame;

    if (imageURIS != null) {
      data['image_uris'] = imageURIS!.toJson();
    }

    data['card_faces'] =
        cardFaces.map((cardFace) => cardFace.toJson()).toList();

    return data;
  }
}
