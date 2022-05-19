import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  Dialogs._();

  static showLoader() {
    Get.dialog(
      Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CupertinoActivityIndicator(
            radius: 20,
          ),
        ),
      ),
    );
  }

  static closeDialog() => Get.back();
}
