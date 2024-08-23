import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post(
      {required String url,
      required body,
      required String token,
      String? contentType}) async {
    // Make a POST request

    var response = await dio.post(
      url,
      data: body,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          
        },
        contentType: contentType, 
      ),
    );
    return response;
  }
}
