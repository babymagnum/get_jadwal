import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/modules/dashboard/controllers/create_schedule_controller.dart';
import 'package:get_jadwal/widgets/custom_textbutton.dart';
import 'package:get_jadwal/widgets/custom_textfield.dart';

class CreateScheduleDialog extends StatelessWidget {
  CreateScheduleDialog({Key? key}) : super(key: key);

  final _dropdownSelectDayKey = GlobalKey();
  final _controller = Get.put(CreateScheduleController());

  Widget get _dropdownSelectDay {
    return Offstage(
      child: Obx(() => DropdownButton<String>(
          key: _dropdownSelectDayKey,
          value: _controller.selectedDay.value == '' ? 'Senin' : _controller.selectedDay.value,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            _controller.selectedDay(value);
          },
          items: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(value, style: ThemeText.poppinsRegular.copyWith(fontSize: 16),),
                  ),
                  value == _controller.selectedDay.value ?
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
              key: const Key('form-add'),
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Buat Jadwal Kuliah', style: ThemeText.poppinsSemiBold.copyWith(fontSize: 20),)),
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
                      hint: 'Masukkan Mata Kuliah', border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xffE5E5E5))),
                      onChanged: (value) => _controller.inputSchedule(value.trim()),
                    ).marginSymmetric(horizontal: 16),
                  ),
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
                            Expanded(child: Text(_controller.selectedDay.value.isEmpty ? 'Pilih Hari' : _controller.selectedDay.value, style: ThemeText.poppinsRegular.copyWith(fontSize: 16, color: _controller.selectedDay.value.isEmpty ? ThemeColor.hint : ThemeColor.textPrimary),)),
                            const SizedBox(width: 10,),
                            Icon(Icons.keyboard_arrow_down_rounded, color: ThemeColor.textPrimary, size: 24,)
                          ],
                        );
                      }),
                    ),
                  ).marginSymmetric(horizontal: 16),
                  _dropdownSelectDay,
                  const SizedBox(height: 20,),
                  const Divider(height: 1, color: Color(0xffE5E5E5),),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        return CustomTextButton(
                          key: const Key('btn-submit'),
                          onPressed: _controller.enableBtnSimpan ? () {} : null,
                          borderColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                          buttonColor: ThemeColor.pink.withOpacity(_controller.enableBtnSimpan ? 1 : 0.2),
                          text: 'Simpan',
                        );
                      })
                    ],
                  ).marginSymmetric(horizontal: 16)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
