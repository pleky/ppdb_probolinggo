import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ppdb/app/core/services/storage_service.dart';
import 'package:ppdb/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String? accessToken = StorageService.getToken();
    print('access token $accessToken');
    return accessToken == null ? null : const RouteSettings(name: Routes.HOME);
  }
}
