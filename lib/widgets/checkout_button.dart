import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/values/strings.dart';
import 'package:get_jadwal/routes/routes.dart';
import 'package:get_jadwal/widgets/custom_textbutton.dart';
import 'package:get_storage/get_storage.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 36,
        child: CustomTextButton(
          key: const Key('btn-logout'),
          onPressed: () async {
            await GetStorage().erase();
            Get.offAllNamed(Routes.checkin);
          },
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          buttonColor: ThemeColor.pink,
          textWidget: Text('Checkout | asdasda sdasd ${GetStorage().read(PrefsKey.LOGED_EMAIL)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: ThemeText.poppinsBold.copyWith(color: Colors.white, fontSize: 12),),
        ),
      ),
    );
  }
}
