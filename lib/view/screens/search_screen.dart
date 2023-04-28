import 'package:flutter/material.dart';
import 'package:placeholder_name/model/api/api_response.dart';
import 'package:placeholder_name/view/widgets/card_list_widget.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/view_model/card_view_model.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  Widget getCardWidget(BuildContext context, ApiResponse apiResponse) {
    List<api.Card>? cardList = apiResponse.data as List<api.Card>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: CardListWidget(cardList!, (Card card) {
                Provider.of<CardViewModel>(context, listen: false);
              }),
            ),
          ],
        );
      case Status.ERROR:
        return Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Search the card by tags'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponse apiResponse = Provider.of<CardViewModel>(context).response;
    return Scaffold(
      appBar: AppBar(
        title: Text('Card search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        controller: _inputController,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Provider.of<CardViewModel>(context, listen: false)
                                .fetchCardData(Uri.encodeFull(value));
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter card name',
                        )),
                  ),
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
