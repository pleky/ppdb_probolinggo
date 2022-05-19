import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ppdb/app/core/constants/my_colors.dart';
import 'package:ppdb/app/core/themes/theme_text.dart';
import 'package:ppdb/app/core/extentions/spacing_extention.dart';
import 'package:ppdb/app/core/utils/utils.dart';
import 'package:ppdb/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import 'package:location/location.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: Text(
          'PPDB Online Kota Probolinggo',
          style: ThemeText.bodyText1,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => controller.scaffoldKey.currentState?.openDrawer(),
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Container(
            color: MyColors.primary.withOpacity(0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                  ),
                ),
                SpaceUtils.ks16.height(),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text(
                    'Nama: ',
                    style: ThemeText.bodyText1.copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('Agus Kotak'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text(
                    'NIK: ',
                    style: ThemeText.bodyText1.copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('123123123123'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text(
                    'Nomor Telepon: ',
                    style: ThemeText.bodyText1.copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('08123123'),
                ),
                Spacer(),
                ListTile(
                  title: Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: controller.handleLogout,
                      style: TextButton.styleFrom(
                        primary: MyColors.white,
                        backgroundColor: MyColors.primary,
                      ),
                      child: Text(
                        'Keluar',
                        style: ThemeText.button,
                      ),
                    ),
                  ),
                ),
                SpaceUtils.ks36.height()
              ],
            ),
          ),
        ),
      ),
      body: Obx(() => GoogleMap(
            mapType: MapType.normal,
            circles: Set.from([controller.circle.value]),
            initialCameraPosition: CameraPosition(
              target: controller.currentLocation.value,
              zoom: 5,
            ),
            onMapCreated: controller.onMapCreated,
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.showDialog,
        label: Text('Cari sekolah terdekat'),
        icon: Icon(Icons.search),
      ),
    );
  }
}
