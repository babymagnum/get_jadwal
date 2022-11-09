import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/detail_day/controllers/delete_schedule_controller.dart';
import 'package:get_jadwal/widgets/custom_textbutton.dart';

class DeleteScheduleDialog extends StatelessWidget {
  final ScheduleItem schedule;

  const DeleteScheduleDialog({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteScheduleController>(
      init: DeleteScheduleController(),
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                key: const Key('form-delete'),
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffED4C5C)
                      ),
                      width: 88, height: 88,
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/svg/todo-item-delete-button.svg'),
                    ),
                    const SizedBox(height: 32,),
                    Text('Hapus Mata Kuliah', textAlign: TextAlign.center, style: ThemeText.poppinsSemiBold.copyWith(fontSize: 20),).marginSymmetric(horizontal: 32),
                    const SizedBox(height: 5,),
                    Text('Apakah anda yakin menghapus mata kuliah ${schedule.title}?', key: const Key('form-delete-description'), textAlign: TextAlign.center, style: ThemeText.poppinsRegular.copyWith(fontSize: 14, color: const Color(0xff888888)),).marginSymmetric(horizontal: 32),
                    const SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextButton(
                          key: const Key('btn-close'),
                          onPressed: () => Get.back(),
                          borderColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                          buttonColor: const Color(0xffF4F4F4),
                          text: 'Batal',
                          textColor: const Color(0xff888888),
                        ),
                        const SizedBox(width: 17,),
                        Obx(() {
                          return CustomTextButton(
                            key: const Key('btn-submit'),
                            onPressed: () => controller.deleteSchedule(schedule.id ?? 0),
                            borderColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                            buttonColor: ThemeColor.error,
                            text: controller.deleteScheduleStatus.value == RequestStatus.loading ? 'Deleting...' : 'Hapus',
                          );
                        })
                      ],
                    ).marginSymmetric(horizontal: 16)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
