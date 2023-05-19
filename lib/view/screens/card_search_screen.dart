import 'package:flutter/material.dart';
import 'package:placeholder_name/model/responses/response.dart';
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';
import 'package:placeholder_name/view/widgets/card_list_widget.dart';
import 'package:placeholder_name/view/widgets/styled_text_field.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/view_model/card_view_model.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';

import 'package:provider/provider.dart';

class CardSearchScreen extends StatefulWidget {
  final MainNavigationScreenState parent;

  const CardSearchScreen({super.key, required this.parent});

  @override
  CardSearchScreenState createState() => CardSearchScreenState();
}

class CardSearchScreenState extends State<CardSearchScreen>
    with
        RestorationMixin,
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin {
  final inputController = RestorableTextEditingController();

  Widget _handleApiResponse(BuildContext context, Response apiResponse) {
    List<api.MTGCard>? cardList = apiResponse.data as List<api.MTGCard>?;

    switch (apiResponse.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CardListWidget(cardList!, (api.MTGCard card) {
                Provider.of<CardViewModel>(context, listen: false);
              }),
            ),
          ],
        );
      case Status.error:
        return const Center(
          child: Text('Please try again later!'),
        );
      case Status.initial:
      default:
        return const Center(
          child: Text('Search the cards by tags'),
        );
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Search Scryfall Cards'),
      backgroundColor: const Color(0x00FFFFFF),
      elevation: 0.0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
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

  Widget _styledFloatingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(icon: const Icon(Icons.add), onPressed: (){
        List<api.MTGCard> selectedCards = Provider.of<CardViewModel>(context, listen:false).selected;
        Provider.of<DeckViewModel>(context, listen:false).addCardsToSelectedDeck(selectedCards);
        Provider.of<CardViewModel>(context, listen: false).removeCards();
      }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Response apiResponse = Provider.of<CardViewModel>(context).response;

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _styledFloatingButton(context),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: StyledTextField(inputController: inputController, submitSearch: submitSearch),
                ),
              ],
            ),
          ),
          Expanded(child: _handleApiResponse(context, apiResponse)),
        ],
      ),
    );
  }

  @override
  String? get restorationId => "search_screen";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(inputController, "searchBarInput");
  }

  @override
  bool get wantKeepAlive => true;
}
