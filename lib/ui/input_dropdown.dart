
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown({Key key, this.labelText, this.value, this.callback})
      : super(key: key);

  final String labelText;
  final DateTime value;
  final Function(DateTime) callback;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => _selectDate(context, callback),
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text('${value.year}-${value.month}-${value.day}'),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, Function(DateTime) callback) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      callback(picked);
    }
  }
}