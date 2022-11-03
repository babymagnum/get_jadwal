import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/dashboard/dashboard_controller.dart';
import 'package:get_jadwal/modules/dashboard/widgets/activity_group_item.dart';
import 'package:get_jadwal/routes/routes.dart';
import 'package:get_jadwal/widgets/custom_reload.dart';
import 'package:get_jadwal/widgets/custom_textbutton_icon.dart';
import 'package:get_storage/get_storage.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  Widget get _activityGroup {
    return controller.scheduleStatus.value == RequestStatus.loading ?
        const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Color(0xff16ABF8)),
        )) :
        controller.scheduleStatus.value == RequestStatus.error ?
        CustomReload(onTap: () => controller.getActivityGroup()) :
        Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff16ABF8),
        title: Text('TO DO LIST APP', style: ThemeText.poppinsBold.copyWith(fontSize: 18, color: Colors.white), key: const ValueKey('header-title'),),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                GetStorage().erase();
                Get.offAllNamed(Routes.checkin);
              },
              child: Text('LOGOUT'),
            ),
          ),
          const SizedBox(width: 16,)
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Activity', key: const ValueKey('activity-title'), style: ThemeText.poppinsBold.copyWith(fontSize: 16, color: const Color(0xff111111)),)),
                CustomTextButtonIcon(text: 'Tambah', iconColor: Colors.white, borderWidth: 0, iconSize: 18, textColor: Colors.white, backgroundColor: const Color(0xff16ABF8), padding: const EdgeInsets.all(9.5), iconData: Icons.add, key: const ValueKey('activity-add-button'), onPressed: () {})
              ],
            ).marginOnly(top: 28).marginSymmetric(horizontal: 20),
            _activityGroup
          ],
        );
      }),
    );
  }
}
