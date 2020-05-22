import 'package:employees/blocs/employee/employees_bloc.dart';
import 'package:employees/repositories/repositories.dart';
import 'package:employees/simple_bloc_delegate.dart';
import 'package:employees/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final personRepo = PersonRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(
    create: (context) {
      return EmployeesBloc(personRepo)..add(EmployeesLoaded());
    },
    child: MyApp(personRepo: personRepo),
  ));
}

class MyApp extends StatelessWidget {
  final PersonRepository personRepo;

  const MyApp({Key key, this.personRepo}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employees',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
