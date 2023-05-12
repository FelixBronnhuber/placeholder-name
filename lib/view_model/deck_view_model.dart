import 'package:flutter/cupertino.dart';
import 'package:placeholder_name/model/deck_repository.dart';
import 'package:placeholder_name/model/responses/response.dart';
import 'package:placeholder_name/model/deck.dart';

class DeckViewModel with ChangeNotifier {

  Response<List<Deck>> _deckResponse = Response.initial('Empty Data');

  Response get response{
    return _deckResponse;
  }

  Future<void> fetchDeckData() async
  {
    _deckResponse = Response.loading('Loading Deck data');

    notifyListeners();

    try {
      List<Deck> deckList = await DeckRepository().getDeckList();
      _deckResponse = Response.completed(deckList);
    } catch (e) {
      _deckResponse = Response.error(e.toString());
    }

    notifyListeners();
  }
}