import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:placeholder_name/model/deck.dart';

class DeckRepository {
  Future<List<Deck>> getDeckList() async {
    final fileDecks = await _loadDecksFromFile();
    return fileDecks;
  }

  Future<List<Deck>> _loadDecksFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/decks.json');
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final deckJsonList = json.decode(jsonString) as List<dynamic>;
        return deckJsonList.map((json) => Deck.fromJson(json)).toList();
      } else {
        await file.create(); // Create the file if it doesn't exist
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading decks from file: $e');
      }
    }
    return [];
  }

  Future<void> _saveDecksToFile(List<Deck> decks) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/decks.json');
      final jsonString =
          json.encode(decks.map((deck) => deck.toJson()).toList());
      File newFile = await file.writeAsString(jsonString);
      String s = await newFile.readAsString();
      if (kDebugMode) {
        print(s);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving decks to file: $e');
      }
    }
  }

  Future<void> editDeck(Deck deck) async {
    final deckList = await getDeckList();
    final index = deckList.indexWhere((d) => d.id == deck.id);
    if (index != -1) {
      deckList[index] = deck;
      await _saveDecksToFile(deckList);
    }
  }

  Future<void> appendDeck(Deck deck) async {
    final deckList = await getDeckList();
    deckList.add(deck);
    await _saveDecksToFile(deckList);
  }
}
