

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/src/models/add_employee_model.dart';
import 'package:sample/src/models/designation_model.dart';
import 'package:sample/src/models/get_employees_model.dart';
import 'package:sample/src/repositories/employee_repository.dart';
import 'package:sample/src/util/app_enums.dart';
import 'package:sample/src/widgets/dropdown_widget.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
   final EmployeeRepository? employeeRepository;
   bool initialEventsDispatched = false; 
  List<GenderModel> genderList = [
    GenderModel(id: 1, name: 'male'),
    GenderModel(id: 2, name: 'female')
  ];
  EmployeeBloc({this.employeeRepository}) : super(EmployeeInitial()) {
    on<GetEmployeeEvent>((event, emit) async {
      await _handleGetEmployee(event, emit);
    });
    on<AddEmployeeEvent>((event, emit) async {
      await _handleAddEmployee(event, emit);
    });
    on<GetDesignationEvent>((event, emit) async {
      await _handleGetDesignation(event, emit);
    });
      on<DropdownDataEvent>((event, emit) async{
     await _dropDownData(event, emit);
    });
       on<DropdownGenderDataEvent>((event, emit) async{
     await _genderdropdowndata(event, emit);
    });
  }

  Future<void> _handleGetEmployee(
      GetEmployeeEvent event, Emitter<EmployeeState> emit) async {
    try {
       emit(GetEmployeeState(status: ApiRequestStatus.loading));

      final  getEmployeesResponse =
      await (employeeRepository ?? EmployeeRepository()).getEmployees();
if(getEmployeesResponse.isSuccess()){
   final employeesList = getEmployeesResponse.getSuccess()?.data?.data;
   if(employeesList != null){
emit(GetEmployeeState(
          status: ApiRequestStatus.success,
          resp: employeesList)
          );
   }
 
}
     
    } catch (e) {
      print("object");
    }
  }

  Future<void> _handleAddEmployee(
      AddEmployeeEvent event, Emitter<EmployeeState> emit) async {
    try {
       emit(GetEmployeeState(status: ApiRequestStatus.loading));
  
      final  addemployeeResponse =
          await EmployeeRepository().addEmployees(postParams: event.reqParams);
        
if(addemployeeResponse.isSuccess()){
   final addEmployeesModel = addemployeeResponse.getSuccess();
   if(addEmployeesModel != null){
emit(AddEmployeeState(
          status: ApiRequestStatus.success, resp: addEmployeesModel));
   }

}
    } catch (e) {
      print("object");
    }
  }

    _dropDownData(DropdownDataEvent event, Emitter<EmployeeState> emit) {
    final selectedCategory = event.dropDownSelect;

    
    emit(DropdownDataState(dropDownSelect: selectedCategory));
  }

   _genderdropdowndata(DropdownGenderDataEvent event, Emitter<EmployeeState> emit) {
    final genderselectedCategory = event.gendeDdropDownSelect;

    
    emit(GenderDropdownDataState(gendeDdropDownSelect: genderselectedCategory));
  }

  

  Future<void> _handleGetDesignation(
      GetDesignationEvent event, Emitter<EmployeeState> emit) async {
    try {
      final designationResp =
          await EmployeeRepository().getDesignation();

      if(designationResp.isSuccess()){
   final designationModel = designationResp.getSuccess()?.data?.data;
   if(designationModel != null){
 emit(GetDesignationState(
          status: ApiRequestStatus.success,
          resp: designationModel));
   }}

     
    } catch (e) {
      print("object");
    }
  }
}
