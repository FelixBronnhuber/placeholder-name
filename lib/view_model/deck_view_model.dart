import 'package:flutter/foundation.dart';
import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/model/deck_repository.dart';

class DeckViewModel with ChangeNotifier {
  DeckRepository deckRepository = DeckRepository();

  Deck? _selectedDeck;

  Deck? get selectedDeck => _selectedDeck;

  set selectedDeck(Deck? deck) {
    _selectedDeck = deck;
    notifyListeners();
  }

  void addCardsToSelectedDeck(List<MTGCard> cards) {
    selectedDeck?.cards.addAll(cards);
    notifyListeners();
  }
}
