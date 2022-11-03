import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/values/enums.dart';
import 'package:get_jadwal/modules/checkin/checkin_controller.dart';
import 'package:get_jadwal/widgets/custom_textbutton.dart';
import 'package:get_jadwal/widgets/custom_textfield.dart';

class CheckinView extends GetView<CheckinController> {
  const CheckinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1), offset: const Offset(0, 6), blurRadius: 10, spreadRadius: 0
                    )
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text('Check In', key: const Key('text-login'), style: ThemeText.poppinsSemiBold.copyWith(fontSize: 24),),
                  ),
                  const SizedBox(height: 24,),
                  Text('Email', style: ThemeText.poppinsMedium.copyWith(fontSize: 16),),
                  const SizedBox(height: 7,),
                  CustomTextField(
                    key: const Key('input-email'),
                    hint: 'Masukkan email anda',
                    onChanged: (value) {
                      controller.email(value);
                      controller.isButtonEnable(false);
                    },
                    fillColor: const Color(0xffF4F4F4),
                    border: OutlineInputBorder(borderSide: const BorderSide(color: const Color(0xffE5E5E5), width: 1), borderRadius: BorderRadius.circular(6)),
                  ),
                  controller.validators(controller.email.value) == null ?
                  Container() :
                  RichText(key: const Key('error-email'), text: TextSpan(
                      children: [
                        WidgetSpan(child: SvgPicture.asset('assets/svg/ep_warning-filled.svg').marginOnly(right: 8.4)),
                        TextSpan(
                            text: controller.validators(controller.email.value),
                            style: ThemeText.poppinsRegular.copyWith(fontSize: 16, color: ThemeColor.error)
                        )
                      ]
                  )).marginOnly(top: 7),
                  const SizedBox(height: 22,),
                  CustomTextButton(
                    key: const Key('btn-login'),
                    onPressed: controller.disableBtnLogin ? null : () {
                      controller.checkin();
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    text: controller.checkinStatus.value == RequestStatus.loading ? 'Checking...' : 'Mulai Sesi',
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                    borderColor: Colors.transparent,
                    buttonColor: const Color(0xffD9019C).withOpacity(controller.disableBtnLogin ? 0.2 : 1),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
