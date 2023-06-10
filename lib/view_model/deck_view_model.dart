import 'package:flutter/cupertino.dart';
import 'package:placeholder_name/model/card.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/model/deck_repository.dart';

class DeckViewModel with ChangeNotifier {
  DeckRepository deckRepository = DeckRepository();
  List<MTGCard> selectedCards = [];

  Deck? _selectedDeck;

  Deck? get selectedDeck => _selectedDeck;

  List<MTGCard> get selected {
    return selectedCards;
  }

  set selectedDeck(Deck? deck) {
    _selectedDeck = deck;
    notifyListeners();
  }

  void addCardsToSelectedDeck(List<MTGCard> cards) {
    selectedDeck?.cards.addAll(cards);
    notifyListeners();
  }

  Future<void> removeCardsFromSelectedDeck() async {
    try {
      List<MTGCard>? cardList = selectedDeck?.cards;
      for(MTGCard card in selectedCards)
      {
        cardList!.remove(card);
      }
      selectedDeck?.cards = cardList!;
      selectedCards = [];
    } catch(e){}
    notifyListeners();
  }

  Future<void> updateSelectedCards(MTGCard card, bool b) async {
    try {
      if (b) {
        selectedCards.add(card);
      } else {
        selectedCards.remove(card);
      }
    } catch(e){}
  }
}
