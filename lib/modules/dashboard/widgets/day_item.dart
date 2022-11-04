import 'package:flutter/material.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';

class DayItem extends StatelessWidget {
  final String day;
  final int data;
  final Key titleKey;
  final Key descKey;

  DayItem({required this.titleKey, required this.descKey, required this.day, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 17, right: 17, top: 13, bottom: 17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1), offset: const Offset(0, 6), blurRadius: 10, spreadRadius: 0
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(day, key: titleKey, style: ThemeText.poppinsBold.copyWith(fontSize: 14),),
          ),
          const SizedBox(height: 6,),
          Text(data == 0 ? 'Belum ada mata kuliah' : '$data Mata Kuliah', key: descKey, maxLines: 1, overflow: TextOverflow.ellipsis, style: ThemeText.poppinsMedium.copyWith(color: data == 0 ? const Color(0xffBBBBBB) : ThemeColor.pink, fontSize: data == 0 ? 12 : 14),),
        ],
      ),
    );
  }
}
