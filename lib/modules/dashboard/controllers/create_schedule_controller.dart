import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/data/model/day.dart';
import 'package:get_jadwal/data/repository/schedule_repository.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/dashboard/controllers/dashboard_controller.dart';

class CreateScheduleController extends GetxController {
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
  var createScheduleStatus = RequestStatus.idle.obs;

  bool get enableBtnSimpan {
    return (inputSchedule.value.isNotEmpty && !selectedDay.value.isEmpty) && createScheduleStatus.value != RequestStatus.loading;
  }

  void postSchedule() async {
    createScheduleStatus(RequestStatus.loading);
    final response = await _scheduleRepository.postSchedule({
      "title": inputSchedule.value,
      "day": selectedDay.value.code
    });
    createScheduleStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);
    
    response.fold((l) {
      Get.snackbar('Error!', 'Error: $l', backgroundColor: Colors.white);
    }, (r) {
      Get.back();
      Get.snackbar('Success!', 'Schedule created successfuly!', backgroundColor: Colors.white);

      _dashboardController.getAllSchedule();
    });
  }
}