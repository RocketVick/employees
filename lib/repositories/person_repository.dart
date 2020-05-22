import 'package:employees/models/models.dart';

class PersonRepository {
  List<Employee> employees;
  List<Child> children;

  PersonRepository() {
    employees = List<Employee>();
    children = List<Child>();
    var firstEmployee =
        Employee('Петр', 'Сергеевич', 'Иванов', DateTime(1982, 12, 2), 'Продавец');
    var firstChild =
        Child('Павел', 'Петрович', 'Иванов', DateTime(2004, 1, 2), firstEmployee.id);

    employees.add(firstEmployee);
    children.add(firstChild);
  }

  void addEmployee(Employee employee) {
    employees.add(employee);
  }

  void addChild(Child child) {
    children.add(child);
  }
}
