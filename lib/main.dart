import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/data/networking/base_service.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_jadwal/routes/pages.dart';
import 'package:get_jadwal/routes/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:flutter_driver/driver_extension.dart';

// Put all controllers that you want to use it globally.
void initCoreService() {
  Get.put(BaseService(), permanent: true);
}

void initFlutterDriver() async {
  enableFlutterDriverExtension();

  await FlutterDriver.connect();
}

void main() async {
  // Uncomment below code for automation build test.
  // initFlutterDriver();

  initCoreService();

  initializeDateFormatting('ID');

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  String get _initialRoute {
    final isLogin = GetStorage().read(PrefsKey.IS_LOGIN) ?? false;
    return isLogin ? Routes.dashboard : Routes.checkin;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      initialRoute: _initialRoute,
      getPages: AppPages.pages,
    );
  }
}
