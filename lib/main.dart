import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppdb/app/core/services/api_service.dart';
import 'package:ppdb/app/core/services/storage_service.dart';
import 'package:ppdb/app/routes/app_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Get.put(APIService());

  StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.LOGIN,
      locale: const Locale('id', "ID"),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      themeMode: ThemeMode.light,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
    );
  }
}
