import 'package:flutter/material.dart';
import 'package:placeholder_name/view_model/deck_list_options_view_model.dart';
import 'package:provider/provider.dart';

class DeckEditPreviewCard extends StatelessWidget {
  const DeckEditPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeckListOptionsViewModel>(builder: (context, vm, child) {
      return Card(
        color: Colors.white,
        borderOnForeground: true,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            onTap: () {},
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: (vm.image != null)
                        ? Image.network(vm.image!, height: 110)
                        : const SizedBox(
                            height: 110,
                            child: Center(
                              child: Text("Please select an image",
                                  style: TextStyle(fontSize: 10.0)),
                            ),
                          ),
                  )),
              const Spacer(flex: 100),
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(vm.deckFormat?.name ?? "Please select a format",
                          style: const TextStyle(fontSize: 15)),
                      Text(vm.name ?? "Please select a name",
                          style: const TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic)),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          if (vm.isWhite)
                            SizedBox(
                              width: 25.0,
                              child: Image.asset(MTGColors.white.imageAssetPath,
                                  height: 20.0),
                            ),
                          if (vm.isBlue)
                            SizedBox(
                              width: 25.0,
                              child: Image.asset(MTGColors.blue.imageAssetPath,
                                  height: 20.0),
                            ),
                          if (vm.isBlack)
                            SizedBox(
                              width: 25.0,
                              child: Image.asset(MTGColors.black.imageAssetPath,
                                  height: 20.0),
                            ),
                          if (vm.isRed)
                            SizedBox(
                              width: 25.0,
                              child: Image.asset(MTGColors.red.imageAssetPath,
                                  height: 20.0),
                            ),
                          if (vm.isGreen)
                            SizedBox(
                              width: 25.0,
                              child: Image.asset(MTGColors.green.imageAssetPath,
                                  height: 20.0),
                            ),
                        ],
                      )
                    ],
                  ))
            ])),
      );
    });
  }
}
