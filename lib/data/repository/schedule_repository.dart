import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/data/model/add_schedule.dart';
import 'package:get_jadwal/data/model/all_schedule.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';
import 'package:get_jadwal/data/networking/base_service.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_storage/get_storage.dart';

abstract class ScheduleRepository {
  Future<Either<String, AllScheduleData>> getAllSchedule();
  Future<Either<String, ScheduleItem>> postSchedule(dynamic body);
  Future<Either<String, ScheduleItem>> patchSchedule(int scheduleId, dynamic body);
  Future<Either<String, List<ScheduleItem>>> getDetailSchedule(String email, String day);
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
  Future<Either<String, ScheduleItem>> postSchedule(dynamic body) async {
    final response = await baseService.postRequest(url: '/schedule?email=$email', body: body);

    if (response.isOk) {
      final data = AddSchedule.fromJson(response.body);

      return data.data != null ? Right(data.data!) : Left(response.body['message'] ?? 'Tidak ada data');
    } else {
      return Left(response.body['message'] ?? 'Tidak ada data');
    }
  }

  @override
  Future<Either<String, List<ScheduleItem>>> getDetailSchedule(String email, String day) async {
    final response = await baseService.getRequest(url: '/schedule?email=$email&day=$day');

    if (response.isOk) {
      final data = DetailSchedule.fromJson(response.body);

      return data.data != null ? Right(data.data!) : Left(response.body['message'] ?? 'Tidak ada data');
    } else {
      return Left(response.body['message'] ?? 'Tidak ada data');
    }
  }

  @override
  Future<Either<String, ScheduleItem>> patchSchedule(int scheduleId, dynamic body) async {
    final response = await baseService.patchRequest(url: '/schedule?email=$email&id=$scheduleId', body: body);

    if (response.isOk) {
      final data = AddSchedule.fromJson(response.body);

      return data.data != null ? Right(data.data!) : Left(response.body['message'] ?? 'Tidak ada data');
    } else {
      return Left(response.body['message'] ?? 'Tidak ada data');
    }
  }
}