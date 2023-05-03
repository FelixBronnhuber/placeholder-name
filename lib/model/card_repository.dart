import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/services/scryfall_service.dart';

class CardRepository {
  final ScryfallService _scryfallService = ScryfallService();

  Future<List<Card>> fetchCardList(String value) async {
    dynamic response = await _scryfallService.getResponse(value);
    final jsonData = response['data'] as List;
    List<Card> cardList =
        jsonData.map((tagJson) => Card.fromJson(tagJson)).toList();
    return cardList;
  }
}
