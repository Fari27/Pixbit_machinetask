import 'package:sample/src/config/api_service_url.dart';
import 'package:sample/src/core/api_service.dart';
import 'package:sample/src/models/add_employee_model.dart';
import 'package:sample/src/models/designation_model.dart';
import 'package:sample/src/models/get_employees_model.dart';
import 'package:sample/src/util/results.dart';

class EmployeeRepository {
  Future<Result<Exception,GetEmployeesModel>> getEmployees() async {
    final Map<String, dynamic> resp = await ApiService()
        .getJSONRequestWithJWTToken(url: ApiServiceUrls.viewEmployees);
    return Success(GetEmployeesModel.fromJson(resp));
  }

  Future<Result<Exception,AddEmployeesModel>> addEmployees({required dynamic postParams}) async {
    dynamic  resp = await ApiService()
        .postRequestWithJWTToken(
            url: ApiServiceUrls.viewEmployees, requestBody: postParams);
    return Success(AddEmployeesModel.fromJson(resp));
  }

  Future<Result<Exception,DesignationModel>> getDesignation() async {
    final Map<String, dynamic> resp = await ApiService()
        .getJSONRequestWithJWTToken(url: ApiServiceUrls.designations);
    return Success(DesignationModel.fromJson(resp));
  }
}
