import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get_jadwal/modules/dashboard/widgets/day_item.dart';
import 'package:get_jadwal/widgets/checkout_button.dart';
import 'package:get_jadwal/widgets/custom_reload.dart';
import 'package:get_jadwal/widgets/custom_textbutton_icon.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  Widget get _scheduleGroup {
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
            CustomReload(onTap: () => controller.getAllSchedule()),
          ],
        ) :
        SingleChildScrollView(
          child: GridView.count(
            primary: false,
            childAspectRatio: 1 / 0.5,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(5, (index) {
              return DayItem(day: controller.day(index), titleKey: Key('card-title-${controller.day(index)}'), descKey: Key('card-desc-${controller.day(index)}'), data: controller.totalSchedule(index));
            }),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.purple,
        title: Text('GetJadwal', style: ThemeText.poppinsBold.copyWith(fontSize: 18, color: Colors.white), key: const ValueKey('header-title'),),
        actions: const [
          CheckoutButton(),
          SizedBox(width: 16,)
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButtonIcon(
                  text: 'Buat Jadwal Kuliah', iconColor: Colors.white,
                  borderWidth: 0, iconSize: 18, textColor: Colors.white,
                  backgroundColor: ThemeColor.pink,
                  padding: const EdgeInsets.all(9.5),
                  iconData: Icons.add,
                  key: const Key('btn-create-schedule'),
                  onPressed: () => controller.showDialogCreateSchedule(dialogType: CreateEditSchedule.create),
                )
              ],
            ).marginOnly(top: 16, bottom: 16).marginSymmetric(horizontal: 16),
            const Divider(height: 1, color: Color(0xffBBBBBB),),
            Expanded(child: _scheduleGroup)
          ],
        );
      }),
    );
  }
}
