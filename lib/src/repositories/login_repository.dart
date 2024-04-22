import 'package:sample/src/config/api_service_url.dart';
import 'package:sample/src/core/api_service.dart';
import 'package:sample/src/models/login_model.dart';

class LoginRepository {
  Future<LoginModel> loginRequest({required dynamic postParams}) async {
    final Map<String, dynamic> resp = await ApiService()
        .postJSONRequest(url: ApiServiceUrls.login, requestBody: postParams);
        
    return LoginModel.fromJson(resp);
    
  }
}
