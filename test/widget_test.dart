// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:placeholder_name/main.dart';

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:placeholder_name/model/deck.dart';

void main() {
  test("Test deck from json", () {
    var json = """
{
    "id": 1,
    "name": "Omnath Madness",
    "format": "Commander",
    "cards": [
        {
            "id": "4ce5b167-df7a-499e-8dcc-7aec2e28b382",
            "uri": "https://api.scryfall.com/cards/4ce5b167-df7a-499e-8dcc-7aec2e28b382",
            "name": "Omnath, Locus of Mana",
            "power": "1",
            "toughness": "1",
            "frame": "2015",
            "image_uris": {
                "png": "https://cards.scryfall.io/png/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.png?1610161645",
                "border_crop": "https://cards.scryfall.io/border_crop/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "art_crop": "https://cards.scryfall.io/art_crop/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "large": "https://cards.scryfall.io/large/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "normal": "https://cards.scryfall.io/normal/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "small": "https://cards.scryfall.io/small/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645"
            },
            "card_faces": []
        },
        {
            "id": "4ce5b167-df7a-499e-8dcc-7aec2e28b389",
            "uri": "https://api.scryfall.com/cards/4ce5b167-df7a-499e-8dcc-7aec2e28b382",
            "name": "Omnath, Locus of Mana2",
            "power": "2",
            "toughness": "2",
            "frame": "2015",
            "image_uris": {
                "png": "https://cards.scryfall.io/png/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.png?1610161645",
                "border_crop": "https://cards.scryfall.io/border_crop/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "art_crop": "https://cards.scryfall.io/art_crop/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "large": "https://cards.scryfall.io/large/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "normal": "https://cards.scryfall.io/normal/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645",
                "small": "https://cards.scryfall.io/small/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645"
            },
            "card_faces": []
        }
    ],
    "image": "https://cards.scryfall.io/border_crop/front/4/c/4ce5b167-df7a-499e-8dcc-7aec2e28b382.jpg?1610161645"
}
  """;

    Deck deck = Deck.fromJson(jsonDecode(json));

    expect(deck.id, 1);
    expect(deck.name, "Omnath Madness");
    expect(deck.format, DeckFormat.commander);
    expect(deck.cards.length, 2);

    expect(jsonEncode(deck.toJson()), jsonEncode(jsonDecode(json)));
  });
}
