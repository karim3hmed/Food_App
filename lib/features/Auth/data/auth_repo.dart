import 'package:dio/dio.dart';
import 'package:foodapp/core/Network/api_error.dart';
import 'package:foodapp/core/Network/api_exception.dart';
import 'package:foodapp/core/Network/api_service.dart';
import 'package:foodapp/core/utils/pref_helper.dart';
import 'package:foodapp/features/Auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  // login
  Future<UserModel?> login(String email, String Password) async {
    try {
      final response = await apiService.post("/login", {
        "email": email,
        "password": Password,
      });

      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];

        if (code != 200 || data == null) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromjson(response["data"]);
        if (user.token != null) {
          await PrefHelper.savetoken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: "there was an error");
      }
    } on DioError catch (e) {
      throw ApiException.handlerror(e);
    } catch (e) {
      if (e is ApiError) {
        throw e; // ✅ رجّعه زي ما هو
      } else {
        throw ApiError(message: "Unexpected error");
      }
    }
  }

  // sign up

  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post("/register", {
        "name": name,
        "email": email,
        "password": password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response["message"];
        final code = int.tryParse(response["code"].toString());

        final data = response["data"];

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? "Signup failed");
        }
        final user = UserModel.fromjson(data);
        if (user.token != null) {
          await PrefHelper.savetoken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: "Expected error from Server");
      }
    } on DioError catch (e) {
      throw ApiException.handlerror(e);
    } catch (e) {
      if (e is ApiError) {
        throw e;
      }
      throw ApiError(message: "Unexpected error");
    }
  }

  // logout

  Future<void> logout() async {
    final response = await apiService.post("/logout", {});

    if (response["data"] != null) {
      throw ApiError(message: "there was an error");
    }
    await PrefHelper.clearToken();
  }

  // get profile data
  Future<UserModel?> getprofiledata() async {
    try {
      final response = await apiService.get("/profile");

      return UserModel.fromjson(response["data"]);
    } on DioError catch (e) {
      throw ApiException.handlerror(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // update data
  Future<UserModel?> updatedata(
    String name,
    String email,
    String address,
  ) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
      });

      final response = await apiService.post("/update-profile", formData);

      if (response is Map<String, dynamic>) {
        final code = response["code"];
        final message = response["message"];
        final data = response["data"];

        if (code == 200 || code == 201) {
          return UserModel.fromjson(data);
        }

        throw ApiError(message: message ?? "Update failed");
      }

      throw ApiError(message: "Invalid server response");
    } on DioError catch (e) {
      throw ApiException.handlerror(e);
    } on ApiError {
      rethrow;
    } catch (_) {
      throw ApiError(message: "Unexpected error");
    }
  }
}
