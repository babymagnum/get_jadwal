import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/data/model/all_schedule.dart';
import 'package:get_jadwal/data/networking/base_service.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_storage/get_storage.dart';

abstract class DashboardRepository {
  Future<Either<String, AllScheduleData>> getAllSchedule();
}

class DashboardRepositoryImpl extends DashboardRepository {

  final baseService = Get.find<BaseService>();

  @override
  Future<Either<String, AllScheduleData>> getAllSchedule() async {
    final email = GetStorage().read(PrefsKey.LOGED_EMAIL);

    final response = await baseService.getRequest(url: '/schedule?email=$email');

    if (response.statusCode == 200 && response.isOk) {
      final data = AllSchedule.fromJson(response.body);

      return data.data != null ? Right(data.data!) : Left(response.body['message'] ?? 'Tidak ada data');
    } else {
      return Left(response.body['message'] ?? 'Tidak ada data');
    }
  }

}