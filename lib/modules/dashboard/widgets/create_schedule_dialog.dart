import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/model/day.dart';
import 'package:get_jadwal/data/model/detail_schedule.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/dashboard/controllers/create_schedule_controller.dart';
import 'package:get_jadwal/widgets/custom_textbutton.dart';
import 'package:get_jadwal/widgets/custom_textfield.dart';

class CreateEditScheduleDialog extends StatelessWidget {
  final String? currentDetailDay;
  final ScheduleItem? scheduleItem;
  final CreateEditSchedule dialogType;

  CreateEditScheduleDialog({Key? key, required this.dialogType, this.scheduleItem, this.currentDetailDay}) : super(key: key);

  final _dropdownSelectDayKey = GlobalKey();

  bool get _hideSelectDay => currentDetailDay != null || scheduleItem != null;

  Widget get _dropdownSelectDay {
    return Offstage(
      child: Obx(() => DropdownButton<Day>(
          key: _dropdownSelectDayKey,
          value: CreateScheduleController.to.selectedDay.value.isEmpty ? CreateScheduleController.to.day.first : CreateScheduleController.to.selectedDay.value,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (Day? value) {
            CreateScheduleController.to.selectedDay(value);
          },
          items: CreateScheduleController.to.day.map<DropdownMenuItem<Day>>((Day value) {
            return DropdownMenuItem<Day>(
              key: Key('btn-dropdown-${value.day}'),
              value: value,
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(value.day ?? '', style: ThemeText.poppinsRegular.copyWith(fontSize: 16),),
                  ),
                  value == CreateScheduleController.to.selectedDay.value ?
                  Icon(Icons.check_rounded, color: ThemeColor.pink, size: 20,).marginOnly(left: 24) :
                  Container()
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _openDropdownSelectDay() {
    GestureDetector? detector;

    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
          return;
        } else {
          searchForGestureDetector(element);
        }

        return;
      });
    }

    searchForGestureDetector(_dropdownSelectDayKey.currentContext!);
    assert(detector != null);

    detector!.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateScheduleController>(
      init: CreateScheduleController(_hideSelectDay, scheduleItem),
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  key: Key(dialogType == CreateEditSchedule.create ? 'form-add' : 'detail-form'),
                  padding: const EdgeInsets.only(top: 20, bottom: 8),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(dialogType == CreateEditSchedule.edit ? 'Edit Mata kuliah' : _hideSelectDay ? 'Tambah Mata Kuliah' : 'Buat Jadwal Kuliah', style: ThemeText.poppinsSemiBold.copyWith(fontSize: 20),)),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              key: const Key('close-modal'),
                              onTap: () => Get.back(),
                              child: Icon(Icons.close, color: ThemeColor.textPrimary, size: 24,),
                            )
                          ],
                        ).marginSymmetric(horizontal: 16),
                        const SizedBox(height: 20,),
                        const Divider(height: 1, color: Color(0xffE5E5E5),),
                        const SizedBox(height: 20,),
                        Text('Mata Kuliah', style: ThemeText.poppinsMedium.copyWith(fontSize: 16),).marginSymmetric(horizontal: 16),
                        const SizedBox(height: 8,),
                        SizedBox(
                          height: 48,
                          child: CustomTextField(
                            key: const Key('form-matkul'),
                            initialValue: scheduleItem?.title,
                            inputAction: TextInputAction.done,
                            onEditingComplete: () => FocusScope.of(context).unfocus(),
                            hint: 'Masukkan Mata Kuliah', border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xffE5E5E5))),
                            onChanged: (value) => controller.inputSchedule(value.trim()),
                          ).marginSymmetric(horizontal: 16),
                        ),
                        if (controller.showInputScheduleError) ...[
                          Text('*Field Mata Kuliah kosong!', key: const Key('field-error-matkul'), style: ThemeText.poppinsRegular.copyWith(
                            fontSize: 12,
                            color: ThemeColor.error,
                          ),).marginSymmetric(horizontal: 16)
                        ],
                        if (!_hideSelectDay) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20,),
                              Text('Pilih Hari', style: ThemeText.poppinsMedium.copyWith(fontSize: 16),).marginSymmetric(horizontal: 16),
                              const SizedBox(height: 8,),
                              GestureDetector(
                                onTap: () => _openDropdownSelectDay(),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  key: const Key('form-day'),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xffE5E5E5)),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  height: 48,
                                  child: Obx(() {
                                    return Row(
                                      children: [
                                        Expanded(child: Text(controller.selectedDay.value.isEmpty ? 'Pilih Hari' : controller.selectedDay.value.day ?? '', style: ThemeText.poppinsRegular.copyWith(fontSize: 16, color: controller.selectedDay.value.isEmpty ? ThemeColor.hint : ThemeColor.textPrimary),)),
                                        const SizedBox(width: 10,),
                                        Icon(Icons.keyboard_arrow_down_rounded, color: ThemeColor.textPrimary, size: 24,)
                                      ],
                                    );
                                  }),
                                ),
                              ).marginSymmetric(horizontal: 16),
                              _dropdownSelectDay,
                              if (controller.showSelectDayError) ...[
                                const SizedBox(height: 8,),
                                Text('*Field Pilih Hari kosong!', key: const Key('field-error-pilih-hari'), style: ThemeText.poppinsRegular.copyWith(
                                  fontSize: 12,
                                  color: ThemeColor.error,
                                ),).marginSymmetric(horizontal: 16)
                              ],
                            ],
                          ),
                        ],
                        const SizedBox(height: 20,),
                        const Divider(height: 1, color: Color(0xffE5E5E5),),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() {
                              return CustomTextButton(
                                key: const Key('btn-submit'),
                                onPressed: () {
                                  if (scheduleItem != null) {
                                    controller.patchSchedule();
                                  } else {
                                    controller.postSchedule(currentDetailDay: currentDetailDay);
                                  }
                                },
                                borderColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                                buttonColor: ThemeColor.pink,
                                text: controller.createScheduleStatus.value == RequestStatus.loading ? 'Creating...' : 'Simpan',
                              );
                            })
                          ],
                        ).marginSymmetric(horizontal: 16)
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
