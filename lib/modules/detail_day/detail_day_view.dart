import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get_jadwal/modules/detail_day/detail_day_controller.dart';
import 'package:get_jadwal/widgets/custom_textbutton_icon.dart';

class DetailDayView extends GetView<DetailDayController> {

  static const String SELECTED_DAY = 'SELECTED_DAY';

  DetailDayView({Key? key}) : super(key: key);

  final _dashboardController = Get.find<DashboardController>();

  Widget get _scheduleList {
    return Obx(() {
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeColor.purple,
        title: Text(controller.selectedDay, style: ThemeText.poppinsBold.copyWith(fontSize: 18, color: Colors.white), key: const ValueKey('header-title'),),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24,),
          CustomTextButtonIcon(
            text: 'Tambah Mata Kuliah', iconColor: Colors.white,
            borderWidth: 0, iconSize: 18, textColor: Colors.white,
            backgroundColor: ThemeColor.pink,
            padding: const EdgeInsets.all(9.5),
            iconData: Icons.add,
            key: const Key('btn-create-schedule'),
            onPressed: () => _dashboardController.showDialogCreateSchedule(hideSelectDay: true),
          ),
          const SizedBox(height: 24,),
          const Divider(height: 1, color: Color(0xffBBBBBB),),
          Expanded(
            child: _scheduleList,
          )
        ],
      ),
    );
  }
}
