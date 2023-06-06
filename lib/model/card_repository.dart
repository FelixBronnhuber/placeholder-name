import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/services/scryfall_service.dart';

class CardRepository {
  final ScryfallService _scryfallService = ScryfallService();

  Future<List<MTGCard>> fetchCardList(String value) async {
    dynamic response = await _scryfallService.getResponse(value);

    List<MTGCard> cardList = [];

    if (response == null) return cardList;

    final jsonData = response['data'] as List;

    if (jsonData.isEmpty) return cardList;

    cardList = jsonData.map((tagJson) => MTGCard.fromJson(tagJson)).toList();

    return cardList;
  }
}
