import 'package:flutter/material.dart';
import 'package:placeholder_name/view/screens/deck_list_options_screen.dart';
import 'package:placeholder_name/view/widgets/deck_list_widget.dart';
import 'package:placeholder_name/view_model/deck_list_options_view_model.dart';
import 'package:provider/provider.dart';

class DecksListScreen extends StatefulWidget {
  const DecksListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DecksListScreenState();
}

class _DecksListScreenState extends State<DecksListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search your Decks'),
        backgroundColor: const Color(0x00FFFFFF),
        elevation: 0.0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),
      ),
      floatingActionButton: _styledFloatingButton(context),
      body: Column(children: [Container(child: _deckListWidget(context))]),
    );
  }

  Widget _styledFloatingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Provider.of<DeckListOptionsViewModel>(context, listen: false)
                .cleanTemporaryDeckValues();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DeckListOptionScreen()));
          }),
    );
  }

  Widget _deckListWidget(BuildContext context) {
    return const Expanded(child: DeckListWidget());
  }

  @override
  bool get wantKeepAlive => true;
}
