import 'package:employees/models/models.dart';
import 'package:employees/ui/input_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef OnSaveCallback = Function(Child employee);

class AddChildrenScreen extends StatefulWidget {
  final String parentId;
  final OnSaveCallback onSave;

  const AddChildrenScreen({Key key, this.onSave, this.parentId}) : super(key: key);

  @override
  _AddChildrenScreenState createState() => _AddChildrenScreenState();
}

class _AddChildrenScreenState extends State<AddChildrenScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _lastName;
  String _firstName;
  String _middleName;
  DateTime _birthdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Добавление ребенка'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: '',
                  key: Key('lastName'),
                  decoration: InputDecoration(
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
                  // style: textTheme.subhead,
                  decoration: InputDecoration(
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
                    hintText: 'Отчество',
                  ),
                  validator: (val) {
                    return val.trim().isEmpty ? 'should be not empty' : null;
                  },
                  onSaved: (value) => _middleName = value,
                ),
                InputDropdown(
                  labelText: 'Укажите дату рождения',
                  callback: (picked) {
                    setState(() {
                      _birthdate = picked;
                    });
                  },
                  value: _birthdate ?? DateTime.now(),
                )
              ],
            )),
        floatingActionButton: FloatingActionButton(
          key: Key('addChildBtn'),
          tooltip: 'Добавление ребенка',
          child: Icon(Icons.add),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.onSave(
                  Child(_firstName, _middleName, _lastName, DateTime.now(), widget.parentId));
              Navigator.pop(context);
            }
          },
        ));
  }
}
