import 'package:dio/dio.dart';
import 'package:foodapp/core/Network/api_error.dart';

class ApiException {
  static Never handlerror(DioError error) {
    final statuscode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data["message"] != null) {
      throw ApiError(message: data["message"], statusCode: statuscode);
    }

    if (statuscode == 302) {
      throw ApiError(message: "This email is already registered.");
    }

    switch (error.type) {
      case DioErrorType.connectionTimeout:
        throw ApiError(message: "Bad connection");
      case DioErrorType.badResponse:
        throw ApiError(message: "please try again ..");
      default:
        throw ApiError(message: "there is an error ");
    }
  }
}
