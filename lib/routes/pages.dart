import 'package:get/get.dart';
import 'package:get_jadwal/modules/checkin/checkin_binding.dart';
import 'package:get_jadwal/modules/checkin/checkin_view.dart';
import 'package:get_jadwal/modules/dashboard/dashboard_view.dart';
import 'package:get_jadwal/modules/detail_day/detail_day_binding.dart';
import 'package:get_jadwal/modules/detail_day/detail_day_view.dart';
import 'package:get_jadwal/routes/routes.dart';
import '../modules/dashboard/dashboard_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.checkin,
      page: () => const CheckinView(),
      binding: CheckinBinding(),
    ),
    GetPage(
      name: Routes.detailDay,
      page: () => DetailDayView(),
      binding: DetailDayBinding(),
    ),
  ];
}
