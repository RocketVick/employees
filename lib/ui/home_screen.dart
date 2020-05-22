import 'package:employees/blocs/employee/employees_bloc.dart';
import 'package:employees/models/models.dart';
import 'package:employees/ui/add_screen.dart';
import 'package:employees/ui/children_screen.dart';
import 'package:employees/ui/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники'),
      ),
      body:
          BlocBuilder<EmployeesBloc, EmployeesState>(builder: (context, state) {
        if (state is EmployeesInitial || state is EmployeesPending) {
          return Loader();
        }
        if (state is EmployeesFetched) {
          return ListView.builder(
              itemCount: state.employees.length,
              itemBuilder: (context, index) {
                final currentEmployee = state.employees[index];
                final children = state.children
                    .where((e) => e.parentId == currentEmployee.id)
                    .toList();
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChildrenScreen(
                                employeeId: currentEmployee.id,
                                employeeName: currentEmployee.lastName,
                              ))),
                  child: EmployeeWidget(
                    employee: currentEmployee,
                    childrenCount: children.length,
                  ),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddScreen(
                        onSave: (employee) {
                          BlocProvider.of<EmployeesBloc>(context)
                              .add(EmployeeAdded(employee));
                        },
                      )));
        },
      ),
    );
  }
}

class EmployeeWidget extends StatelessWidget {
  final Employee employee;
  final int childrenCount;

  const EmployeeWidget({Key key, this.employee, this.childrenCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(Icons.person),
          title: Text(employee.fullName),
          subtitle: Text('${employee.age} лет, ${employee.position}'),
          trailing: childrenCount > 0
              ? Text('Дети: ${childrenCount.toString()}')
              : Text('Детей нет')),
    );
  }
}
