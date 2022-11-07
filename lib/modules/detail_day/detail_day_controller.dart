import 'package:get/get.dart';
import 'package:get_jadwal/core/custom_extension.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';
import 'package:get_jadwal/data/repository/schedule_repository.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_jadwal/modules/detail_day/detail_day_view.dart';
import 'package:get_storage/get_storage.dart';

class DetailDayController extends GetxController {
  late String selectedDay;

  final _scheduleRepository = ScheduleRepositoryImpl();

  final scheduleStatus = RequestStatus.idle.obs;
  final schedules = <ScheduleItem>[].obs;

  void getSchedules() async {
    scheduleStatus(RequestStatus.loading);
    final response = await _scheduleRepository.getDetailSchedule(GetStorage().read(PrefsKey.LOGED_EMAIL), selectedDay.getDayCode);
    scheduleStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);

    response.fold((l) {}, (r) => schedules.assignAll(r));
  }

  @override
  void onInit() {
    selectedDay = Get.arguments[DetailDayView.SELECTED_DAY];

    getSchedules();

    super.onInit();
  }
}