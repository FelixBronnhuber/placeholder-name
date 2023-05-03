import 'image_uris.dart';

class CardFace {
  final String layout;
  final ImageURIS? imageURIS;

  const CardFace({required this.layout, required this.imageURIS});

  factory CardFace.fromJson(Map<String, dynamic> json) {
    ImageURIS? imageURIS;
    if (json['image_uris'] != null) {
      imageURIS = ImageURIS.fromJson(json['image_uris']);
    }

    return CardFace(layout: json['layout'].toString(), imageURIS: imageURIS);
  }
}