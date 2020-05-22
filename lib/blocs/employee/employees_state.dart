part of 'employees_bloc.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => [];
}

class EmployeesInitial extends EmployeesState {}

class EmployeesPending extends EmployeesState {}

class EmployeesFetched extends EmployeesState {
  final List<Employee> employees;
  final List<Child> children;

  EmployeesFetched({this.employees = const [], this.children = const []});

  EmployeesFetched copyWith({
    List<Child> children,
    List<Employee> employees,
  }) {
    return EmployeesFetched(
      employees: employees ?? this.employees,
      children: children ?? this.children,
    );
  }

  @override
  List<Object> get props => [employees, children];
}
