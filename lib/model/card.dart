import 'card_face.dart';
import 'image_uris.dart';

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