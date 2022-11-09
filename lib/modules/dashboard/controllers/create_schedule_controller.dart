import 'package:get/get.dart';
import 'package:get_jadwal/data/model/day.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';
import 'package:get_jadwal/data/repository/schedule_repository.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get_jadwal/modules/detail_day/controllers/detail_day_controller.dart';

class CreateScheduleController extends GetxController {
  final bool hideSelectDay;
  final ScheduleItem? scheduleItem;

  CreateScheduleController(this.hideSelectDay, this.scheduleItem) {
    inputSchedule(scheduleItem?.title ?? '');
  }

  final _scheduleRepository = ScheduleRepositoryImpl();
  final _dashboardController = Get.find<DashboardController>();
  
  final day = [
    Day('Senin', 'monday'),
    Day('Selasa', 'tuesday'),
    Day('Rabu', 'wednesday'),
    Day('Kamis', 'thursday'),
    Day('Jumat', 'friday'),
  ];
  
  var inputSchedule = ''.obs;
  var selectedDay = Day.empty().obs;
  var btnSimpanClicked = false.obs;
  var createScheduleStatus = RequestStatus.idle.obs;

  bool get enableBtnSimpan {
    // if (hideSelectDay) return inputSchedule.value.isNotEmpty && createScheduleStatus.value != RequestStatus.loading;

    return /*(inputSchedule.value.isNotEmpty && !selectedDay.value.isEmpty) && */createScheduleStatus.value != RequestStatus.loading;
  }

  bool get showInputScheduleError {
    return inputSchedule.value.isEmpty && btnSimpanClicked.value;
  }

  bool get showSelectDayError {
    if (hideSelectDay) return false;

    return selectedDay.value.isEmpty && btnSimpanClicked.value;
  }

  void patchSchedule() async {
    if (showInputScheduleError) return;

    createScheduleStatus(RequestStatus.loading);
    final response = await _scheduleRepository.patchSchedule(scheduleItem?.id ?? 0, {
      "title": inputSchedule.value,
      "day": scheduleItem?.day
    });
    createScheduleStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);

    response.fold((l) {}, (r) {
      Get.back();

      // check if this method called in detail day or no
      if (!Get.isRegistered<DetailDayController>()) return;

      final _detailDayController = Get.find<DetailDayController>();
      final _selectedScheduleIndex = _detailDayController.schedules.indexOf(scheduleItem);
      _detailDayController.schedules[_selectedScheduleIndex] = r;
    });
  }

  // create schedule for selected day.
  //
  // if [currentDetailDay] != null -> dialog opened from detail day screen.
  void postSchedule({String? currentDetailDay}) async {
    if (showInputScheduleError || showSelectDayError) return;

    createScheduleStatus(RequestStatus.loading);
    final response = await _scheduleRepository.postSchedule({
      "title": inputSchedule.value,
      "day": currentDetailDay ?? selectedDay.value.code
    });
    createScheduleStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);
    
    response.fold((l) {}, (r) {
      Get.back();

      _dashboardController.getAllSchedule();

      // check if this method called in detail day or no
      if (!Get.isRegistered<DetailDayController>()) return;

      final _detailDayController = Get.find<DetailDayController>();
      _detailDayController.schedules.add(r);
    });
  }
}