import 'package:placeholder_name/model/card_repository.dart';
import 'package:placeholder_name/model/services/load_deck_service.dart';

import 'deck.dart';

class DeckRepository {
  final LoadDeckService _loadDeckService = LoadDeckService();

  // placeholder
  List<Deck>? deckList = [
    Deck(
        id: 0,
        name: "Omnath Madness",
        format: DeckFormat.commander,
        cards: [],
        image:
            "https://cards.scryfall.io/art_crop/front/3/3/33d94ecf-758b-4f68-a7be-6bf3ff1047f4.jpg?1682205643"),
    Deck(
        id: 1,
        name: "Arcades Defenders",
        format: DeckFormat.commander,
        cards: [],
        image:
            "https://cards.scryfall.io/art_crop/front/1/e/1e90c638-d4b2-4243-bbc4-1cc10516c40f.jpg?1666961830"),
    Deck(
        id: 1,
        name: "Annoying Hofri",
        format: DeckFormat.commander,
        cards: [],
        image:
            "https://cards.scryfall.io/art_crop/front/b/d/bd8deecf-eded-418b-ac4c-5c3e8f54e86d.jpg?1627429212"),
    Deck(
        id: 2,
        name: "Dina Lifegain",
        format: DeckFormat.pauper,
        cards: [],
        image:
            "https://cards.scryfall.io/art_crop/front/9/c/9cd2b567-0cf7-4441-b3ce-e31141dd91c8.jpg?1627428607"),
    Deck(
        id: 3,
        name: "Fynn Deathtouch",
        format: DeckFormat.pauper,
        cards: [],
        image:
            "https://cards.scryfall.io/art_crop/front/7/d/7d7a8a90-13c1-4b0c-ab2e-fc8d91ccefd9.jpg?1631050242"),
  ];

  Future<List<Deck>> getDeckList() async {
    var deckJson = await _loadDeckService.load();

    deckList ??= []; //TODO: Load deck from file

    return deckList!;
  }
}
