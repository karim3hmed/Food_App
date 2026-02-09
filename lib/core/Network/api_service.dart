import 'package:dio/dio.dart';
import 'package:foodapp/core/Network/api_error.dart';
import 'package:foodapp/core/Network/api_exception.dart';
import 'package:foodapp/core/Network/dio_client.dart';

class ApiService {
  // ignore: unused_field
  final DioClient _dioClient = DioClient();

  // get
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handlerror(e);
    }
  }

  // post
  Future<dynamic> post(String path, dynamic data) async {
    try {
      final response = await _dioClient.dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiError(message: e.response?.data['message'] ?? 'Network error');
    }
  }

  // delete
  Future<dynamic> delete(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.delete(endpoint, data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handlerror(e);
    }
  }

  // put
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioError catch (e) {
      return ApiException.handlerror(e);
    }
  }
}
