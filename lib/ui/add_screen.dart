import 'package:employees/models/models.dart';
import 'package:employees/ui/input_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef OnSaveCallback = Function(Employee employee);

class AddScreen extends StatefulWidget {
  final OnSaveCallback onSave;

  const AddScreen({Key key, this.onSave}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _lastName;
  String _firstName;
  String _middleName;
  String _position;
  DateTime _birthdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Добавление сотрудника'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: '',
                  key: Key('lastName'),
                  decoration: InputDecoration(
                    labelText: 'Введите фамилию',
                    hintText: 'Фамилия',
                  ),
                  validator: (val) {
                    return val.trim().isEmpty ? 'should be not empty' : null;
                  },
                  onSaved: (value) => _lastName = value,
                ),
                TextFormField(
                  initialValue: '',
                  key: Key('firstName'),
                  decoration: InputDecoration(
                    labelText: 'Введите имя',
                    hintText: 'Имя',
                  ),
                  validator: (val) {
                    return val.trim().isEmpty ? 'should be not empty' : null;
                  },
                  onSaved: (value) => _firstName = value,
                ),
                TextFormField(
                  initialValue: '',
                  key: Key('middleName'),
                  decoration: InputDecoration(
                    labelText: 'Введите отчество',
                    hintText: 'Отчество',
                  ),
                  validator: (val) {
                    return val.trim().isEmpty ? 'should be not empty' : null;
                  },
                  onSaved: (value) => _middleName = value,
                ),
                TextFormField(
                  initialValue: '',
                  key: Key('position'),
                  decoration: InputDecoration(
                    labelText: 'Введите должность',
                    hintText: 'Должность',
                  ),
                  validator: (val) {
                    return val.trim().isEmpty ? 'should be not empty' : null;
                  },
                  onSaved: (value) => _position = value,
                ),
                InputDropdown(
                  labelText: 'Укажите дату рождения',
                  callback: (picked) {
                    setState(() {
                      _birthdate = picked;
                    });
                  },
                  value: _birthdate ?? DateTime.now(),
                ),
              ],
            )),
        floatingActionButton: FloatingActionButton(
          key: Key('addEmployeeBtn'),
          tooltip: 'Добавление сотрудника',
          child: Icon(Icons.add),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.onSave(Employee(
                  _firstName, _middleName, _lastName, _birthdate, _position));
              Navigator.pop(context);
            }
          },
        ));
  }
}
