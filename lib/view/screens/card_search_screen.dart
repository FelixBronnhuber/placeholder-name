import 'package:flutter/material.dart';
import 'package:placeholder_name/model/card.dart' as api;
import 'package:placeholder_name/model/responses/response.dart';
import 'package:placeholder_name/view/screens/main_navigation_screen.dart';
import 'package:placeholder_name/view/widgets/card_list_widget.dart';
import 'package:placeholder_name/view/widgets/styled_text_field.dart';
import 'package:placeholder_name/view_model/card_view_model.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Response apiResponse = Provider.of<CardViewModel>(context).response;

    return Scaffold(
      appBar: _buildAppBar(),
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
