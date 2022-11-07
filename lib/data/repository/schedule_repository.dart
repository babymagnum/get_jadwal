import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/data/model/all_schedule.dart';
import 'package:get_jadwal/data/networking/base_service.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_storage/get_storage.dart';

abstract class ScheduleRepository {
  Future<Either<String, AllScheduleData>> getAllSchedule();
  Future<Either<String, bool>> postSchedule(dynamic body);
}

class ScheduleRepositoryImpl extends ScheduleRepository {

  final baseService = Get.find<BaseService>();
  final email = GetStorage().read(PrefsKey.LOGED_EMAIL);

  @override
  Future<Either<String, AllScheduleData>> getAllSchedule() async {
    final response = await baseService.getRequest(url: '/schedule?email=$email');

    if (response.isOk) {
      final data = AllSchedule.fromJson(response.body);

      return data.data != null ? Right(data.data!) : Left(response.body['message'] ?? 'Tidak ada data');
    } else {
      return Left(response.body['message'] ?? 'Tidak ada data');
    }
  }

  @override
  Future<Either<String, bool>> postSchedule(dynamic body) async {
    final response = await baseService.postRequest(url: '/schedule?email=$email', body: body);

    if (response.isOk) {
      return const Right(true);
    } else {
      return Left(response.body['message'] ?? 'Tidak ada data');
    }
  }
}