import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_jadwal/data/model/all_schedule.dart';
import 'package:get_jadwal/data/repository/dashboard_repository.dart';
import 'package:get_jadwal/data/values/enums.dart';

class DashboardController extends GetxController {
  final dashboardRepository = DashboardRepositoryImpl();

  var scheduleStatus = RequestStatus.loading.obs;
  var schedule = AllScheduleData().obs;

  void getActivityGroup() async {
    scheduleStatus(RequestStatus.loading);
    final response = await dashboardRepository.getAllSchedule();
    scheduleStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);

    if (response.isLeft()) return;

    response.fold((l) {}, (r) => schedule(r));

    log('getActivityGroup ${schedule.value.toString()}');
  }

  @override
  void onInit() {
    getActivityGroup();

    super.onInit();
  }
}