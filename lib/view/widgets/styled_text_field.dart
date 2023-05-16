import 'package:flutter/material.dart';
import 'package:placeholder_name/view/widgets/styled_box_shadow.dart';

class StyledTextField extends StatelessWidget {
  final RestorableTextEditingController inputController;
  final Function(String) submitSearch;

  const StyledTextField({super.key, required this.inputController, required this.submitSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [StyledBoxShadow.build()],
      ),
      child: TextField(
        style: const TextStyle(
          fontSize: 12.0,
        ),
        controller: inputController.value,
        autocorrect: false,
        onSubmitted: submitSearch,
        decoration: _buildInputDecoration(),
      ),
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
      hintText: 'Enter Scryfall query',
      isDense: true,
    );
  }
}