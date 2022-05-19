import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ppdb/app/core/data/repositories/auth_repository.dart';
import 'package:ppdb/app/core/services/api_service.dart';
import 'package:ppdb/app/core/services/storage_service.dart';
import 'package:ppdb/app/global_widgets/dialogs.dart';
import 'package:ppdb/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController nikController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepository repo = AuthRepository(Get.find<APIService>().instance);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> onLogin() async {
    final isValid = formKey.currentState?.validate();
    if (isValid == true) {
      Dialogs.showLoader();
      final response = await repo.login(nikController.text);

      if (response != null) {
        await StorageService.saveToken(response.token);
        await StorageService.saveUID(response.uid);

        Get.offAllNamed(Routes.HOME);
      }
    }
  }
}
