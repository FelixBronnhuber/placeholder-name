import 'package:flutter/foundation.dart';
import 'package:placeholder_name/model/card_repository.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/model/deck_repository.dart';

class DeckListOptionsViewModel with ChangeNotifier {
  final DeckRepository _deckRepository = DeckRepository();

  List<Deck> decks = [];

  DeckFormat? deckFormat;
  String? name;
  String? image;
  bool isWhite = false;
  bool isBlue = false;
  bool isBlack = false;
  bool isRed = false;
  bool isGreen = false;
  String? csv;

  DeckListOptionsViewModel() {
    updateDeckList();
  }

  void updateDeckList() async {
    decks = await _deckRepository.getDeckList();
    notifyListeners();
  }

  void loadValuesFromExistingDeck(Deck deck) {
    deckFormat = deck.format;
    name = deck.name;
    image = deck.image;
    isWhite = deck.isWhite;
    isBlue =  deck.isBlue ;
    isBlack = deck.isBlack;
    isRed = deck.isRed;
    isGreen = deck.isGreen;

    //TODO: Add the colors to the deck model
    //TODO: Load the colors from the deck

    //TODO: Implement a deck.toCSV
    //TODO: set the csv using deck.toCSV
  }

  Future<bool> updateAsExistingDeck({required int id}) async {
    if(!areFieldsValid()) return false;

    int index = decks.indexWhere((Deck deck) => deck.id == id);

    if (index < 0) return false;

    Deck updatedDeck = deckFactory();
    updatedDeck.id = id;
    updatedDeck.cards = decks[index].cards;

    decks[index] = updatedDeck;

    _deckRepository.editDeck(updatedDeck);

    notifyListeners();

    return true;
  }

  Future<bool> updateAsNewDeck() async {
    if (!areFieldsValid()) return false;

    Deck deck = deckFactory();

    DeckRepository().appendDeck(deck);

    decks.add(deck);

    cleanTemporaryDeckValues();

    notifyListeners();

    return true;
  }

  bool areFieldsValid() {
    return name != null &&
      deckFormat != null &&
      image != null &&
      (isWhite | isBlue | isBlack | isRed | isGreen);
  }

  void toggledWhite() {
    isWhite = !isWhite;
    notifyListeners();
  }

  void toggledBlue() {
    isBlue = !isBlue;
    notifyListeners();
  }

  void toggledBlack() {
    isBlack = !isBlack;
    notifyListeners();
  }

  void toggledRed() {
    isRed = !isRed;
    notifyListeners();
  }

  void toggledGreen() {
    isGreen = !isGreen;
    notifyListeners();
  }

  void changeFormat(DeckFormat format) {
    deckFormat = format;
    notifyListeners();
  }

  void changeName(String name) {
    this.name = name;
    notifyListeners();
  }

  void changeImageFromQuery(String query) async {
    CardRepository().fetchCardList(Uri.encodeFull(query)).then((cards) {
      if (cards.isEmpty) return;

      // TODO: Give the user the option to cycle through his queried cards

      // This should probably be somewhere else:
      image = cards.first.imageURIS?.artCrop ??
          cards.first.cardFaces.first.imageURIS?.artCrop;

      notifyListeners();
    });
  }

  void cleanTemporaryDeckValues() {
    deckFormat = null;
    name = null;
    image = null;
    isWhite = false;
    isBlue = false;
    isBlack = false;
    isRed = false;
    isGreen = false;
    csv = null;
  }

  void saveDeck(Deck? deck) {
    if (deck == null) return;

    _deckRepository.editDeck(deck);
  }

  Deck deckFactory() {
    int id = 0;
    for (Deck deck in decks) {
      if (deck.id >= id) {
        id = deck.id + 1;
      }
    }

    return Deck(
      id: id,
      name: name!,
      format: deckFormat!,
      cards: [],
      image: image!,
      isWhite: isWhite,
      isBlue : isBlue,
      isBlack: isBlack,
      isRed:   isRed,
      isGreen: isGreen,
    );
  }
}

enum MTGColors {
  white(imageAssetPath: "assets/W.png"),
  blue(imageAssetPath: "assets/U.png"),
  black(imageAssetPath: "assets/B.png"),
  red(imageAssetPath: "assets/R.png"),
  green(imageAssetPath: "assets/G.png");

  const MTGColors({required this.imageAssetPath});

  final String imageAssetPath;
}
