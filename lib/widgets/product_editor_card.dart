import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class ProductEditorCard extends StatefulWidget {
  final DateTime? expiryDate;
  final int? quantity;
  final double? currentPrice;
  final String indexKey;
  const ProductEditorCard({
    super.key,
    required this.indexKey,
    this.expiryDate,
    this.quantity,
    this.currentPrice,
  });

  @override
  State<ProductEditorCard> createState() => _ProductEditorCardState();
}

class _ProductEditorCardState extends State<ProductEditorCard> {
  late TextEditingController dateTimeController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController quantityController = TextEditingController();
  DateTime? selectedDateTime;

  Future<void> pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;
    if (!mounted) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
      initialTime:
          selectedDateTime != null
              ? TimeOfDay.fromDateTime(selectedDateTime!)
              : TimeOfDay.now(),
    );

    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      selectedDateTime = dateTime;
      dateTimeController.text = DateFormat(
        'yyyy/MM/dd HH:mm:ss',
      ).format(dateTime);
    });
  }

  @override
  void initState() {
    super.initState();

    dateTimeController = TextEditingController(
      text: formatDateTime(widget.expiryDate),
    );

    if (widget.currentPrice != null) {
      final priceText = widget.currentPrice.toString();
      priceController = TextEditingController(text: priceText);
    } else {
      priceController = TextEditingController(text: '');
    }

    if (widget.quantity != null) {
      final quantityText = widget.quantity.toString();
      quantityController = TextEditingController(text: quantityText);
    } else {
      quantityController = TextEditingController(text: '');
    }
  }

  String formatDateTime(DateTime? dt) {
    if (dt == null) return '';
    return '${dt.year}/${twoDigits(dt.month)}/${twoDigits(dt.day)} ${twoDigits(dt.hour)}:${twoDigits(dt.minute)}:${twoDigits(dt.second)}';
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.indexKey),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FaIcon(
            FontAwesomeIcons.trash,
            color: Colors.white,
            size: 20.0,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.6),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                cursorColor: Colors.black,
                controller: dateTimeController,
                readOnly: true,
                onTap: pickDateTime,
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 90,
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: priceController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Current Price',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  prefixText: '\$ ',
                  focusColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 80,
              child: TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final intValue = int.tryParse(value);
                  if (intValue == null || intValue < 0) {
                    return 'Value must be at least 1';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
