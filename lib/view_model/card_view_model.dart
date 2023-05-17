import 'package:flutter/cupertino.dart';
import 'package:placeholder_name/model/responses/response.dart';
import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/card_repository.dart';

class CardViewModel with ChangeNotifier {
  Response _apiResponse = Response.initial('Empty Data');
  List<MTGCard> selectedCards = [];

  Response get response {
    return _apiResponse;
  }

  List<MTGCard> get selected {
    return selectedCards;
  }

  Future<void> fetchCardData(String value) async {
    _apiResponse = Response.loading('Fetching card data');

    notifyListeners();

    try {
      List<MTGCard> cardList = await CardRepository().fetchCardList(value);
      _apiResponse = Response.completed(cardList);
    } catch (e) {
      _apiResponse = Response.error(e.toString());
    }

    notifyListeners();
  }

  Future<void> updateSelectedCards(MTGCard card, bool b) async {
    try {
      if (b)
        selectedCards.add(card);
      else
        selectedCards.remove(card);
    } catch(e){}
  }

  Future<void> removeCards() async {
    try {
      List<MTGCard> cardList = _apiResponse.data;
      for(MTGCard card in selectedCards)
      {
        cardList.remove(card);
      }
      selectedCards = [];
    } catch(e){}
    notifyListeners();
  }
}
