import 'package:uuid/uuid.dart';

abstract class Person {
  String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime birthDate;
  static DateTime initialBirthDate = DateTime.now();

  int get age {
    return DateTime.now().year - birthDate.year;
  }

  String get fullName {
    return '$lastName $firstName $middleName';
  }

  Person(this.firstName, this.middleName, this.lastName, birthDate)
      : birthDate = birthDate ?? Person.initialBirthDate {
    var uuid = Uuid();
    id = uuid.v1();
  }
}

class Child extends Person {
  final String parentId;

  Child(String firstName, String middleName, String lastName,
      DateTime birthDate, this.parentId)
      : super(firstName, middleName, lastName, birthDate);
}

class Employee extends Person {
  final String position;

  Employee(String firstName, String middleName, String lastName,
      DateTime birthDate, this.position)
      : super(firstName, middleName, lastName, birthDate);
}
