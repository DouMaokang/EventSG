import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> categoryList;
  final Function(String) onSelectionChanged;

  MultiSelectChip(this.categoryList,{this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // this function will build and return the choice list
//  List<String> selectedChoices = List();
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.categoryList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12),),
          selected: selectedChoice == item,
          onSelected: (selected) {
          setState(() {
          selectedChoice = item;
          widget.onSelectionChanged(selectedChoice);
        });},
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}