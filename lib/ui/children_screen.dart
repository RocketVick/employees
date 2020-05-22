import 'package:employees/blocs/employee/employee.dart';
import 'package:employees/models/models.dart';
import 'package:employees/ui/add_children_screen.dart';
import 'package:employees/ui/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildrenScreen extends StatefulWidget {
  final String employeeId;
  final String employeeName;

  const ChildrenScreen({Key key, this.employeeId, this.employeeName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.employeeName}: Дети'),
      ),
      body:
          BlocBuilder<EmployeesBloc, EmployeesState>(builder: (context, state) {
        if (state is EmployeesInitial) {
          return Loader();
        }
        if (state is EmployeesFetched) {
          final children = state.children
              .where((e) => e.parentId == widget.employeeId)
              .toList();
          return ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) {
                return ChildWidget(child: children[index]);
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddChildrenScreen(
                        parentId: widget.employeeId,
                        onSave: (child) {
                          BlocProvider.of<EmployeesBloc>(context)
                              .add(ChildAdded(child));
                        },
                      )));
        },
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final Child child;

  const ChildWidget({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(Icons.person),
          title: Text(child.fullName)),
    );
  }
}
