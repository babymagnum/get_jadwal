import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/custom_extension.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get_jadwal/modules/detail_day/detail_day_controller.dart';
import 'package:get_jadwal/modules/detail_day/widgets/list_schedule_item.dart';
import 'package:get_jadwal/widgets/custom_reload.dart';
import 'package:get_jadwal/widgets/custom_textbutton_icon.dart';

class DetailDayView extends GetView<DetailDayController> {

  static const String SELECTED_DAY = 'SELECTED_DAY';

  DetailDayView({Key? key}) : super(key: key);

  final _dashboardController = Get.find<DashboardController>();

  Widget get _scheduleList {
    return Obx(() {
      return controller.scheduleStatus.value == RequestStatus.loading ?
      const Center(
        child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Color(0xff16ABF8)),
        )),
      ) :
      controller.scheduleStatus.value == RequestStatus.error ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomReload(onTap: () => controller.getSchedules()),
        ],
      ) :
      controller.schedules.isEmpty ?
      SvgPicture.asset('assets/svg/todo-empty-state.svg', key: const Key('todo-empty-state'), width: Get.width * 0.6, height: Get.width * 0.6,) :
      ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => ListScheduleItem(
          data: controller.schedules[index],
          onDeleteTap: () {},
          onEditTap: () => _dashboardController.showDialogCreateSchedule(dialogType: CreateEditSchedule.edit, scheduleItem: controller.schedules[index]),
        ),
        separatorBuilder: (_, __) => const Divider(height: 10, color: Colors.transparent,),
        itemCount: controller.schedules.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeColor.purple,
        title: Row(
          children: [
            GestureDetector(
              key: const Key('btn-back'),
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24,),
            ),
            const SizedBox(width: 19,),
            Text(controller.selectedDay, style: ThemeText.poppinsBold.copyWith(fontSize: 18, color: Colors.white), key: const Key('detail-title'),),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16,),
          Align(
            alignment: Alignment.centerRight,
            child: CustomTextButtonIcon(
              text: 'Tambah Mata Kuliah', iconColor: Colors.white,
              borderWidth: 0, iconSize: 18, textColor: Colors.white,
              backgroundColor: ThemeColor.pink,
              padding: const EdgeInsets.all(9.5),
              iconData: Icons.add,
              key: const Key('btn-create-schedule'),
              onPressed: () => _dashboardController.showDialogCreateSchedule(dialogType: CreateEditSchedule.create, currentDetailDay: controller.selectedDay.getDayCode),
            ).marginOnly(right: 16),
          ),
          const SizedBox(height: 16,),
          const Divider(height: 1, color: Color(0xffBBBBBB),),
          Expanded(
            child: _scheduleList,
          )
        ],
      ),
    );
  }
}
