import 'package:flutter/cupertino.dart';
import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/model/deck_repository.dart';
import 'package:placeholder_name/model/responses/response.dart';

class DeckViewModel with ChangeNotifier {
  DeckRepository deckRepository = DeckRepository();
  Response<List<Deck>> _deckResponse = Response.initial('Empty Data');

  Deck? _selectedDeck;

  Deck? get selectedDeck => _selectedDeck;

  set selectedDeck(Deck? deck) {
    _selectedDeck = deck;
    notifyListeners();
  }

  Response get response {
    return _deckResponse;
  }

  Future<void> fetchDeckData() async {
    _deckResponse = Response.loading('Loading Deck data');

    notifyListeners();

    try {
      List<Deck> deckList = await deckRepository.getDeckList();
      _deckResponse = Response.completed(deckList);
    } catch (e) {
      _deckResponse = Response.error(e.toString());
    }

    notifyListeners();
  }

  void addCardsToSelectedDeck(List<Card> cards) {
    selectedDeck?.cards.addAll(cards);
  }
}
