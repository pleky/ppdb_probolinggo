import 'package:dio/dio.dart';
import 'package:ppdb/app/core/data/models/login_response.dart';
import 'package:ppdb/app/core/services/api_service.dart';
import 'package:ppdb/app/core/services/storage_service.dart';

class AuthRepository {
  Dio _api;
  AuthRepository(this._api);
  Future<LoginResponse?> login(String nik) async {
    LoginResponse? data;
    try {
      Response response = await _api.post('/login', data: {
        'nik': nik,
      });

      if (response.statusCode == 200) {
        data = LoginResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }

    return data;
  }

  Future<LoginResponse?> getUser() async {
    LoginResponse? data;
    try {
      final String? _uid = StorageService.getUID();
      final String? _token = StorageService.getToken();
      Response response = await _api.get(
        '/users',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'uid': '$_uid',
          },
        ),
      );

      if (response.statusCode == 200) {
        data = LoginResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }

    return data;
  }
}
