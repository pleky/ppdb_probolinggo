import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ppdb/app/core/constants/my_colors.dart';
import 'package:ppdb/app/core/data/repositories/auth_repository.dart';
import 'package:ppdb/app/core/services/api_service.dart';
import 'package:ppdb/app/core/services/storage_service.dart';
import 'package:ppdb/app/core/themes/theme_text.dart';
import 'package:ppdb/app/core/utils/size_utils.dart';

import 'package:ppdb/app/core/extentions/spacing_extention.dart';
import 'package:ppdb/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final circle = const Circle(circleId: CircleId("circle")).obs;
  final Completer<GoogleMapController> mapController = Completer();
  final AuthRepository repo = AuthRepository(Get.find<APIService>().instance);

  Location location = Location();
  final currentLocation = const LatLng(0.7893, 113.9213).obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _dummyList = List.generate(10, (index) => 'Sekolah ${index + 1}');
  final firstSelected = 'Sekolah 1'.obs;
  final secondSelected = 'Sekolah 1'.obs;
  final thirdSelected = 'Sekolah 1'.obs;

  @override
  void onInit() {
    getCurrentLocation();
    getUserData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getUserData() async {
    await repo.getUser();
  }

  void showDialog() {
    Get.defaultDialog(
      title: 'Daftar Sekolah Terdekat',
      contentPadding: EdgeInsets.all(SpaceUtils.ks16),
      titlePadding: EdgeInsets.only(top: SpaceUtils.ks32),
      content: SizedBox(
        width: Get.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceUtils.ks16.height(),
            const Text('Pilih Sekolah Pertama'),
            SpaceUtils.ks8.height(),
            SizedBox(
              width: double.infinity,
              child: Obx(() => DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: const OutlineInputBorder()),
                    value: firstSelected.value,
                    hint: const Text('Pilih Sekolah Pertama'),
                    items: _dummyList
                        .map(
                          (item) => DropdownMenuItem<String>(
                            child: Text(
                              item,
                              style: ThemeText.bodyText1,
                            ),
                            value: item,
                          ),
                        )
                        .toList(),
                    onChanged: (item) => firstSelected.value = item ?? "",
                  )),
            ),
            SpaceUtils.ks16.height(),
            const Text('Pilih Sekolah Kedua'),
            SpaceUtils.ks8.height(),
            SizedBox(
              width: double.infinity,
              child: Obx(() => DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: const OutlineInputBorder()),
                    value: secondSelected.value,
                    hint: const Text('Pilih Sekolah Pertama'),
                    items: _dummyList
                        .map(
                          (item) => DropdownMenuItem<String>(
                            child: Text(
                              item,
                              style: ThemeText.bodyText1,
                            ),
                            value: item,
                          ),
                        )
                        .toList(),
                    onChanged: (item) => secondSelected.value = item ?? '',
                  )),
            ),
            SpaceUtils.ks16.height(),
            const Text('Pilih Sekolah Ketiga'),
            SpaceUtils.ks8.height(),
            SizedBox(
              width: double.infinity,
              child: Obx(() => DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: const OutlineInputBorder()),
                    hint: const Text('Pilih Sekolah Pertama'),
                    value: thirdSelected.value,
                    items: _dummyList
                        .map(
                          (item) => DropdownMenuItem<String>(
                            child: Text(
                              item,
                              style: ThemeText.bodyText1,
                            ),
                            value: item,
                          ),
                        )
                        .toList(),
                    onChanged: (item) => thirdSelected.value = item ?? '',
                  )),
            ),
            SpaceUtils.ks32.height(),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                style: TextButton.styleFrom(
                  primary: MyColors.white,
                  backgroundColor: MyColors.primary,
                ),
                child: Text(
                  'Daftar Zonasi',
                  style: ThemeText.button,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    PermissionStatus _permissionGranted = await location.hasPermission();
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData _locs = await location.getLocation();

    currentLocation.value = LatLng(_locs.latitude!, _locs.longitude!);
    circle.value = Circle(
      circleId: const CircleId("circle"),
      center: LatLng(_locs.latitude!, _locs.longitude!),
      radius: 5000,
      fillColor: Colors.red.withOpacity(0.5),
      strokeColor: Colors.red.withOpacity(0.55),
      strokeWidth: 1,
    );
  }

  void onMapCreated(GoogleMapController c) async {
    mapController.complete(c);
    await getCurrentLocation();
    c.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.value.latitude, currentLocation.value.longitude),
          zoom: 12,
        ),
      ),
    );
  }

  Future<void> handleLogout() async {
    StorageService.clear();
    Get.offAllNamed(Routes.LOGIN);
  }
}
