import 'package:dio/dio.dart';
import 'package:foodapp/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://sonic-zdi0.onrender.com/api",
      headers: {"Content-Type": "application/json"},
    ),
  );

  DioClient() {
    // لازم اسم constructor صح
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          handler.next(options); // مهم جدًا يكمل request حتى لو مفيش token
        },
        onError: (DioError e, handler) {
          handler.next(e); // Pass error
        },
      ),
    );
  }

  Dio get dio => _dio;
}
