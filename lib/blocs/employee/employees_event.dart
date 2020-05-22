part of 'employees_bloc.dart';

abstract class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

class EmployeesLoaded extends EmployeesEvent {}

class EmployeeAdded extends EmployeesEvent {
  final Employee employee;

  const EmployeeAdded(this.employee);

  @override
  List<Object> get props => [employee];

  @override
  String toString() => 'Employee ${employee.lastName} added';
}

class ChildAdded extends EmployeesEvent {

  final Child child;

  const ChildAdded(this.child);

  @override
  List<Object> get props => [child];

  @override
  String toString() => 'Child ${child.lastName} added';
}
