import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employees/models/models.dart';
import 'package:employees/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final PersonRepository personRepository;

  EmployeesBloc(this.personRepository);

  @override
  EmployeesState get initialState => EmployeesInitial();

  @override
  Stream<EmployeesState> mapEventToState(EmployeesEvent event) async* {
    final currentState = state;

    if (event is EmployeesLoaded) {
      yield EmployeesFetched(
          employees: List.from(personRepository.employees),
          children: List.from(personRepository.children));
    }
    if (event is EmployeeAdded) {
      if (state is EmployeesFetched) {
        final List<Employee> updated =
            List.from((state as EmployeesFetched).employees)
              ..add(event.employee);
        yield (currentState as EmployeesFetched).copyWith(employees: updated);
      }
      personRepository.addEmployee(event.employee);
    }
    if (event is ChildAdded) {
      if (state is EmployeesFetched) {
        final List<Child> updated =
            List.from((state as EmployeesFetched).children)..add(event.child);
        yield (currentState as EmployeesFetched).copyWith(children: updated);
        personRepository.addChild(event.child);
      }
    }
  }
}
