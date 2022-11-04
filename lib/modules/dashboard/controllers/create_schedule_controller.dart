import 'package:get/get.dart';

class CreateScheduleController extends GetxController {
  var inputSchedule = ''.obs;
  var selectedDay = ''.obs;

  bool get enableBtnSimpan {
    return inputSchedule.value.isNotEmpty && selectedDay.value.isNotEmpty;
  }
}