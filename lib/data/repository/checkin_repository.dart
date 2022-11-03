import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/data/networking/base_service.dart';

abstract class CheckinRepository {
  Future<Either<String, bool>> checkin(String email);
}

class CheckinRepositoryImpl extends CheckinRepository {

  final baseService = Get.find<BaseService>();

  @override
  Future<Either<String, bool>> checkin(String email) async {
    final response = await baseService.postRequest(url: '/checkin', body: {
      "email": email
    });

    if (response.statusCode == 200 && response.isOk) {
      log('checkin ${response.body}');
      return const Right(true);
    } else {
      return Left(response.body['message'] ?? 'Request error!');
    }
  }

}