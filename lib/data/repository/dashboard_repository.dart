import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/data/model/all_schedule.dart';
import 'package:get_jadwal/data/networking/base_service.dart';

abstract class DashboardRepository {
  Future<Either<String, AllScheduleData>> getAllSchedule();
}

class DashboardRepositoryImpl extends DashboardRepository {

  final baseService = Get.find<BaseService>();

  @override
  Future<Either<String, AllScheduleData>> getAllSchedule() async {
    final response = await baseService.getRequest(url: 'activity-groups?email=yoga%2B1%40skyshi.io');

    if (response.statusCode == 200 && response.isOk) {
      final data = AllSchedule.fromJson(response.body);

      return data.data != null ? Right(data.data!) : Left(response.body['message'] ?? 'Tidak ada data');
    } else {
      return Left(response.body['message'] ?? 'Tidak ada data');
    }
  }

}