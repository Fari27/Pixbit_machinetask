part of 'employee_bloc.dart';

abstract class EmployeeEvent {}

class GetEmployeeEvent extends EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  final Map<String, dynamic> reqParams;
  AddEmployeeEvent({required this.reqParams});
}

class DropdownDataEvent extends EmployeeEvent {
  final DropDownItems dropDownSelect;
  DropdownDataEvent({required this.dropDownSelect});
}

class DropdownGenderDataEvent extends EmployeeEvent {
  final DropDownItems gendeDdropDownSelect;
  DropdownGenderDataEvent({required this.gendeDdropDownSelect});
}

class GetDesignationEvent extends EmployeeEvent {}
