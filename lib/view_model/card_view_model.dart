import 'package:flutter/cupertino.dart';
import 'package:placeholder_name/model/responses/response.dart';
import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/card_repository.dart';

class CardViewModel with ChangeNotifier {
  Response _apiResponse = Response.initial('Empty Data');

  Response get response {
    return _apiResponse;
  }

  Future<void> fetchCardData(String value) async {
    _apiResponse = Response.loading('Fetching card data');

    notifyListeners();

    try {
      List<Card> cardList = await CardRepository().fetchCardList(value);
      _apiResponse = Response.completed(cardList);
    } catch (e) {
      _apiResponse = Response.error(e.toString());
    }

    notifyListeners();
  }
}
