import 'package:get/get.dart';
import 'package:get_jadwal/data/repository/checkin_repository.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_jadwal/routes/routes.dart';
import 'package:get_storage/get_storage.dart';

class CheckinController extends GetxController {
  final checkinRepository = CheckinRepositoryImpl();

  var checkinStatus = RequestStatus.success.obs;
  var email = ''.obs;
  var isButtonEnable = false.obs;

  String? Function(dynamic) get validators {
    return (v) => !GetUtils.isEmail(v) && v != '' ? 'Format email tidak sesuai' : null;
  }

  bool get disableBtnLogin {
    return validators(email.value) != null || checkinStatus.value == RequestStatus.loading || email.isEmpty;
  }

  void checkin() async {
    checkinStatus(RequestStatus.loading);
    final response = await checkinRepository.checkin(email.value);
    checkinStatus(response.isLeft() ? RequestStatus.error : RequestStatus.success);

    response.fold((l) {
      Get.snackbar('Error Checkin!', l);
    }, (r) {
      GetStorage().write(PrefsKey.LOGED_EMAIL, email.value);

      Get.offNamed(Routes.dashboard);
    });
  }
}