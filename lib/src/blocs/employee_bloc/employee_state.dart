part of 'employee_bloc.dart';

abstract class EmployeeState {
  ApiRequestStatus status;
  EmployeeState({this.status = ApiRequestStatus.initial});
}

class EmployeeInitial extends EmployeeState {}

class GetEmployeeState extends EmployeeState {
  List<EmployeesList>? resp;
  GetEmployeeState({ this.resp, super.status});
}

class AddEmployeeState extends EmployeeState {
  AddEmployeesModel resp;
  AddEmployeeState({required this.resp, super.status});
}

class GetDesignationState extends EmployeeState {
  List<DesignationList> resp;
  GetDesignationState({required this.resp, super.status});
}

class DropdownDataState extends EmployeeState {
  final DropDownItems dropDownSelect;
  DropdownDataState({required this.dropDownSelect});
}

class GenderDropdownDataState extends EmployeeState {
  final DropDownItems gendeDdropDownSelect;
  GenderDropdownDataState({required this.gendeDdropDownSelect});
}
