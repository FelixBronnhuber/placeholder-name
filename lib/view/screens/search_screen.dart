import 'package:flutter/material.dart';
import 'package:placeholder_name/model/api/api_response.dart';
import 'package:placeholder_name/view/widgets/card_list_widget.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/view_model/card_view_model.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  Widget getCardWidget(BuildContext context, ApiResponse apiResponse) {
    List<api.Card>? cardList = apiResponse.data as List<api.Card>?;

    switch (apiResponse.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CardListWidget(cardList!, (Card card) {
                Provider.of<CardViewModel>(context, listen: false);
              }),
            ),
          ],
        );
      case Status.error:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.initial:
      default:
        return const Center(
          child: Text('Search the card by tags'),
        );
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Search Scryfall Cards'),
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0.0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      hintText: 'Enter Scryfall query',
      isDense: true,
    );
  }

  Container _buildTextField(TextEditingController inputController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [buildBoxShadow()],
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 12.0,
        ),
        controller: inputController,
        autocorrect: false,
        onSubmitted: submitSearch,
        decoration: _buildInputDecoration(),
      ),
    );
  }

  void submitSearch(String value) {
    if (value.isNotEmpty) {
      Provider.of<CardViewModel>(context, listen: false)
          .fetchCardData(Uri.encodeFull(value));
    }
  }

  BoxShadow buildBoxShadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 0,
      blurRadius: 4,
      offset: const Offset(0, 5), // changes position of shadow
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<CardViewModel>(context).response;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildTextField(inputController),
                ),
              ],
            ),
          ),
          Expanded(child: getCardWidget(context, apiResponse)),
        ],
      ),
    );
  }
}
