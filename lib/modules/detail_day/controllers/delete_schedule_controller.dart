import 'package:get/get.dart';
import 'package:get_jadwal/data/repository/schedule_repository.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get_jadwal/modules/detail_day/controllers/detail_day_controller.dart';

class DeleteScheduleController extends GetxController {
  final _scheduleRepository = ScheduleRepositoryImpl();
  final _detailDayController = Get.find<DetailDayController>();
  final _dashboardController = Get.find<DashboardController>();

  final deleteScheduleStatus = RequestStatus.idle.obs;

  void deleteSchedule(int scheduleId) async {
    deleteScheduleStatus(RequestStatus.loading);
    final response = await _scheduleRepository.deleteSchedule(scheduleId);
    deleteScheduleStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);

    response.fold((l) {}, (r) {
      _dashboardController.getAllSchedule(hideLoading: true);

      Get.back();

      final deletedIndex = _detailDayController.schedules.indexWhere((element) => element.id == scheduleId);
      _detailDayController.schedules.removeAt(deletedIndex);
    });
  }
}