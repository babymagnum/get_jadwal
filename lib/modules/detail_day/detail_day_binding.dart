import 'package:get/get.dart';
import 'package:get_jadwal/modules/detail_day/detail_day_controller.dart';

class DetailDayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailDayController());
  }

}