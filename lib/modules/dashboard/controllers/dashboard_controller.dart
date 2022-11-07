import 'package:get/get.dart';
import 'package:get_jadwal/data/model/all_schedule.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';
import 'package:get_jadwal/data/repository/schedule_repository.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_jadwal/modules/dashboard/controllers/create_schedule_controller.dart';
import 'package:get_jadwal/modules/dashboard/widgets/create_schedule_dialog.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  final _scheduleRepository = ScheduleRepositoryImpl();

  var scheduleStatus = RequestStatus.loading.obs;
  var schedule = AllScheduleData().obs;

  String day(int index) {
    switch(index) {
      case 0: return 'Senin';
      case 1: return 'Selasa';
      case 2: return 'Rabu';
      case 3: return 'Kamis';
      case 4: return 'Jumat';
      default: return 'Senin';
    }
  }

  int totalSchedule(int index) {
    switch(index) {
      case 0: return schedule.value.monday ?? 0;
      case 1: return schedule.value.tuesday ?? 0;
      case 2: return schedule.value.wednesday ?? 0;
      case 3: return schedule.value.thursday ?? 0;
      case 4: return schedule.value.friday ?? 0;
      default: return schedule.value.monday ?? 0;
    }
  }

  String get loggedEmail {
    return GetStorage().read(PrefsKey.LOGED_EMAIL) ?? '';
  }

  void getAllSchedule({bool hideLoading = false}) async {
    if (!hideLoading) scheduleStatus(RequestStatus.loading);
    final response = await _scheduleRepository.getAllSchedule();
    scheduleStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);

    if (response.isLeft()) return;

    response.fold((l) {}, (r) => schedule(r));
  }

  void showDialogCreateSchedule({required CreateEditSchedule dialogType, String? currentDetailDay, ScheduleItem? scheduleItem}) async {
    await Get.dialog(CreateEditScheduleDialog(currentDetailDay: currentDetailDay, scheduleItem: scheduleItem, dialogType: dialogType,));
    Get.delete<CreateScheduleController>();
  }

  @override
  void onInit() {
    getAllSchedule();

    super.onInit();
  }
}