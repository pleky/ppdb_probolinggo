import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ppdb/app/core/constants/my_colors.dart';
import 'package:ppdb/app/core/themes/theme_text.dart';
import 'package:ppdb/app/core/utils/size_utils.dart';
import 'package:ppdb/app/core/extentions/spacing_extention.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SpaceUtils.ks16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.height * 0.3,
                      child: Image.asset('assets/images/probolinggo.png'),
                    ),
                    Text(
                      'Selamat Datang',
                      style: ThemeText.heading1,
                    ),
                    Text('Calon Peserta PPDB', style: ThemeText.heading2),
                    SpaceUtils.ks36.height(),
                    TextFormField(
                      controller: controller.nikController,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'NIK tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'NIK',
                        labelStyle: ThemeText.bodyText1,
                        hintText: 'Masukkan NIK',
                        helperText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(SpaceUtils.ks8),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          controller.onLogin();
                        },
                        style: TextButton.styleFrom(
                          primary: MyColors.white,
                          backgroundColor: MyColors.primary,
                        ),
                        child: Text(
                          'Masuk',
                          style: ThemeText.button,
                        ),
                      ),
                    ),
                    SpaceUtils.ks36.height()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
