import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

BaseOptions _options = BaseOptions(
  baseUrl: dotenv.get('BASE_URL'),
  connectTimeout: 10000,
);

class APIService extends GetxService {
  Dio api = Dio(_options);

  Dio get instance => api;

  @override
  void onInit() {
    api.interceptors.add(PrettyDioLogger());
    print('on init service');
    super.onInit();
  }
}
