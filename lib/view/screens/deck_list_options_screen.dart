import 'package:flutter/material.dart';
import 'package:placeholder_name/model/deck.dart';
import 'package:placeholder_name/view/widgets/CategoryIconText.dart';
import 'package:placeholder_name/view/widgets/deck_edit_preview_card.dart';
import 'package:placeholder_name/view/widgets/mana_symbol_button.dart';
import 'package:placeholder_name/view_model/deck_list_options_view_model.dart';
import 'package:placeholder_name/view_model/deck_view_model.dart';
import 'package:provider/provider.dart';

class DeckListOptionScreen extends StatefulWidget {
  final Deck? deck;

  const DeckListOptionScreen({super.key, this.deck});

  @override
  State<StatefulWidget> createState() => _DeckListOptionScreenState();
}

class _DeckListOptionScreenState extends State<DeckListOptionScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _imageTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.deck != null) {
      Provider.of<DeckListOptionsViewModel>(context, listen: false)
          .loadValuesFromExistingDeck(widget.deck!);

      _nameTextEditingController.text = widget.deck!.name;
    }
  }

  Widget _styledFloatingButton(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: () {
              if (widget.deck == null) {
                Provider.of<DeckListOptionsViewModel>(context, listen: false)
                    .updateAsNewDeck()
                    .then((bool didComplete) {
                  if (didComplete) {
                    Navigator.pop(context);
                  }
                });
              } else {
                Provider.of<DeckListOptionsViewModel>(context, listen: false)
                    .updateAsExistingDeck(id: widget.deck!.id)
                    .then((bool didComplete) {
                  if (didComplete) {
                    Navigator.pop(context);
                  }
                });
              }
            }));
  }

  List<Widget> _buildFormatSelectionButtons(
      BuildContext context, Function(DeckFormat) onPressed) {
    List<Widget> widgets = [];

    for (DeckFormat format in DeckFormat.values) {
      widgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.black, width: 0.5)),
              backgroundColor: MaterialStatePropertyAll(
                  Provider.of<DeckListOptionsViewModel>(context, listen: true)
                              .deckFormat ==
                          format
                      ? const Color(0xFFe8e4e4)
                      : Colors.white),
            ),
            onPressed: () {
              onPressed(format);
            },
            child: Text(
              format.name,
              style: const TextStyle(color: Colors.black),
            ),
          )));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text('Edit Deck'),
        backgroundColor: const Color(0x00FFFFFF),
        elevation: 0.0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24.0,
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CategoryIconText(icon: Icons.preview, text: "Preview"),
              const DeckEditPreviewCard(),
              const SizedBox(height: 5.0),
              const CategoryIconText(
                  icon: Icons.type_specimen, text: "Select format"),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  height: 30,
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: _buildFormatSelectionButtons(context,
                          (DeckFormat format) {
                        setState(() {
                          Provider.of<DeckListOptionsViewModel>(context,
                                  listen: false)
                              .changeFormat(format);
                        });
                      }))),
              const SizedBox(height: 5.0),
              const CategoryIconText(icon: Icons.abc, text: "Choose name"),
              TextField(
                controller: _nameTextEditingController,
                decoration: _buildInputDecoration(),
                style: const TextStyle(fontSize: 10.0),
                onChanged: (name) {
                  Provider.of<DeckListOptionsViewModel>(context, listen: false)
                      .changeName(name);
                },
              ),
              const SizedBox(height: 5.0),
              const CategoryIconText(
                  icon: Icons.image, text: "Choose card for image"),
              TextField(
                controller: _imageTextEditingController,
                decoration: _buildInputDecoration(),
                style: const TextStyle(fontSize: 10.0),
                onSubmitted: (query) {
                  Provider.of<DeckListOptionsViewModel>(context, listen: false)
                      .changeImageFromQuery(query);
                },
              ),
              const SizedBox(height: 5.0),
              const CategoryIconText(
                  icon: Icons.color_lens, text: "Choose colors"),
              Row(
                children: [
                  ManaSymbolButton(
                      asset: "assets/W.png",
                      onPressed: Provider.of<DeckListOptionsViewModel>(context,
                              listen: false)
                          .toggledWhite,
                      isActive: Provider.of<DeckListOptionsViewModel>(context,
                              listen: true)
                          .isWhite),
                  const Spacer(),
                  ManaSymbolButton(
                      asset: "assets/U.png",
                      onPressed: Provider.of<DeckListOptionsViewModel>(context,
                              listen: false)
                          .toggledBlue,
                      isActive: Provider.of<DeckListOptionsViewModel>(context,
                              listen: true)
                          .isBlue),
                  const Spacer(),
                  ManaSymbolButton(
                      asset: "assets/B.png",
                      onPressed: Provider.of<DeckListOptionsViewModel>(context,
                              listen: false)
                          .toggledBlack,
                      isActive: Provider.of<DeckListOptionsViewModel>(context,
                              listen: true)
                          .isBlack),
                  const Spacer(),
                  ManaSymbolButton(
                      asset: "assets/R.png",
                      onPressed: Provider.of<DeckListOptionsViewModel>(context,
                              listen: false)
                          .toggledRed,
                      isActive: Provider.of<DeckListOptionsViewModel>(context,
                              listen: true)
                          .isRed),
                  const Spacer(),
                  ManaSymbolButton(
                      asset: "assets/G.png",
                      onPressed: Provider.of<DeckListOptionsViewModel>(context,
                              listen: false)
                          .toggledGreen,
                      isActive: Provider.of<DeckListOptionsViewModel>(context,
                              listen: true)
                          .isGreen),
                ],
              ),
              const SizedBox(height: 5.0),
              const CategoryIconText(
                  icon: Icons.sim_card_download_rounded,
                  text: "Import .csv decklist"),
              Row(children: [
                Expanded(
                    child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.black, width: 0.5)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Search files",
                    style: TextStyle(color: Colors.black),
                  ),
                ))
              ]),
              const SizedBox(height: 5.0),
              const CategoryIconText(
                  icon: Icons.remove_red_eye_rounded, text: "Import preview"),
              Card(
                  shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  ),
                  child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 50, maxHeight: 200),
                      child: Row(children: const [
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                            softWrap: false,
                                            "not implemented yet")))))
                      ]))),
            ],
          )),
      floatingActionButton: _styledFloatingButton(context),
    );
  }

  InputDecoration _buildInputDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.black, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.black, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.black, width: 0.5),
      ),
      isDense: true,
    );
  }
}
