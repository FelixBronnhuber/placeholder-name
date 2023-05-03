import 'package:flutter/cupertino.dart';
import 'package:placeholder_name/model/api/api_response.dart';
import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/card_repository.dart';

class CardViewModel with ChangeNotifier
{
  ApiResponse _apiResponse = ApiResponse.initial('Empty Data');

  Card? _card;

  ApiResponse get response{
    return _apiResponse;
  }

  Card? get card {
    return _card;
  }

  Future<void> fetchCardData(String value) async
  {
    _apiResponse = ApiResponse.loading('Fetching card data');

    notifyListeners();

    try {
      List<Card> cardList = await CardRepository().fetchCardList(value);
      _apiResponse = ApiResponse.completed(cardList);
    } catch (e){
      _apiResponse = ApiResponse.error(e.toString());
    }

    notifyListeners();
  }

}