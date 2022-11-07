import 'package:get/get.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/detail_day/detail_day_view.dart';

class DetailDayController extends GetxController {
  late String selectedDay;

  final scheduleStatus = RequestStatus.idle.obs;

  @override
  void onInit() {
    selectedDay = Get.arguments[DetailDayView.SELECTED_DAY];

    super.onInit();
  }
}