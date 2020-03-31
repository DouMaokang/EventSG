import 'package:flutter/material.dart';

class SingleSelectChip extends StatefulWidget {
  final List<String> categoryList;
  final Function(String) onSelectionChanged;

  SingleSelectChip(this.categoryList,{this.onSelectionChanged});
  @override
  _SingleSelectChipState createState() => _SingleSelectChipState();
}

class _SingleSelectChipState extends State<SingleSelectChip> {
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