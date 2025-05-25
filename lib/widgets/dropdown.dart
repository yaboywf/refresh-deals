import 'package:flutter/material.dart';

/// A dropdown with custom styling to select a category.
class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedValue = 'All';

  final List<String> items = ['All', 'Vegetable', 'Fruit', 'Meat', 'Pastry', 'Others'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      padding: EdgeInsets.all(0.0),
      hint: Text('Select Category', style: TextStyle(fontSize: 14, color: Colors.black),),
      value: selectedValue,
      isDense: true,
      dropdownColor: Colors.grey[200],
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(fontSize: 12, color: Colors.black),),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
    );
  }
}