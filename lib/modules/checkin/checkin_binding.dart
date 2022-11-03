import 'package:get/get.dart';
import 'package:get_jadwal/modules/checkin/checkin_controller.dart';

class CheckinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckinController());
  }
}