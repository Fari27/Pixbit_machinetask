import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum ApiMethod {
  post_method,
  put_method,
  get_method,
  delete_method,
}

// class ApiClient {
//   ApiClient._();
//   static final instance = ApiClient._();
//   final client = HttpClient();
// }

class ApiService {
  static final ApiService _httpService = ApiService._();

  factory ApiService() => _httpService;

  ApiService._();

  Future<dynamic> postJSONRequest(
      {required String url,
      Object? requestBody,
      int? reqTimeout,
      String? jwtToken}) async {
    final String jsonRequest = json.encode(requestBody);
    final dynamic response;

    response = await fetchRequest(
        apiMethod: ApiMethod.post_method,
        url: url,
        requestBody: jsonRequest,
        reqTimeout: 60,
        jwtToken: jwtToken);

    return response.isEmpty ? response : json.decode(response);
  }

  Future<dynamic> getJSONRequestWithJWTToken(
      {required String url,
      Map<String, String>? reqHeader,
      bool? isEncryption,
      String? jwtToken}) async {
    String jwtToken = await _getToken();
    final dynamic response;

    response = await fetchRequest(
        url: url, apiMethod: ApiMethod.get_method, jwtToken: jwtToken);

    return response.isEmpty ? response : json.decode(response);
  }

  Future<dynamic> postRequestWithJWTToken({
    required String url,
    Map<String, dynamic>? requestBody,
    int? reqTimeout,
  }) async {
    try {
      String jwtToken = await _getToken();
      // final String jsonRequest = json.encode(requestBody);
      final dynamic response;

      response = await sendProfileData(
          url: url, formData: requestBody, token: jwtToken);

      return response;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> sendProfileData(
      {Map<String, dynamic>? formData, String? token, String? url}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://training.pixbit.in/api/employees"),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    };



    var stream =  http.ByteStream(formData?['profile_picture'].openRead());
    stream.cast();
    var length = await formData?['profile_picture'].length();

    request.files.addAll([
      http.MultipartFile(
        'profile_picture',
        stream,
        length,
        filename: 'image',
        contentType: MediaType('image', 'jpeg'),
      ),
      http.MultipartFile(
        'resume',
        formData?['resume'].readAsBytes().asStream(),
        formData?['resume'].lengthSync(),
        filename: 'resume',
        contentType: MediaType('pdf', 'pdf'),
      ),
    ]);
    request.headers.addAll(headers);
    request.fields.addAll({
      "first_name": formData?["first_name"],
      "last_name": formData?["last_name"],
      "join_date": "10-09-2023",
      "date_of_birth": formData?["date_of_birth"],
      "designation_id": formData?["designation_id"],
      "gender": formData?["gender"],
      "email": formData?["email"],
      "mobile": formData?["mobile"],
      "landline": formData?["landline"],
      "present_address": formData?["present_address"],
      "permanent_address": formData?["permanent_address"],
      "status": formData?["status"],
    });

    
   
    var res = await request.send();
   
    return res;
  }
}

Future<String> fetchRequest(
    {String? url,
    String? requestBody,
    Map<String, dynamic>? formData,
    apiMethod = ApiMethod.post_method,
    int? reqTimeout = 60,
    String? jwtToken}) async {
  try {
    Map<String, String>? defaultHeaders;
    defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept-Encoding': 'gzip',
      // 'Content-Encoding': 'gzip',
    };

    if (jwtToken != null && jwtToken.isNotEmpty) {
      defaultHeaders['Authorization'] = 'Bearer $jwtToken';
    }

    String? request;
    request = requestBody;
    dynamic response;
    if (apiMethod == ApiMethod.get_method) {
      if (url != null && url.isNotEmpty) {
        response = await http
            .get(Uri.parse(url), headers: defaultHeaders)
            .timeout(const Duration(seconds: 60));
      }
    } else {
      if (url != null && url.isNotEmpty) {
        response = await http
            .post(
              Uri.parse(url),
              headers: defaultHeaders,
              body: formData ?? requestBody,
            )
            .timeout(const Duration(seconds: 60));
      }
    }

    if (response.statusCode == 200) {
      final responseBody = response.body;
      return responseBody;
    } else {
      return response.toString();
    }
  } catch (e) {
    return e.toString();
  }
}

_getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('jwtToken') ?? '';
  return token;
}
