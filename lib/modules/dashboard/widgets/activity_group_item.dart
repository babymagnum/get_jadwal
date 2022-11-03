import 'package:flutter/material.dart';
import 'package:get_jadwal/core/custom_extension.dart';
import 'package:get_jadwal/core/theme/text_theme.dart';
import 'package:get_jadwal/data/model/activity_group.dart';

class ActivityGroupItem extends StatelessWidget {
  final ActivityGroupData data;

  const ActivityGroupItem({Key? key, required this.data}) : super(key: key);

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
            child: Text(data.title ?? '', style: ThemeText.poppinsBold.copyWith(fontSize: 14),),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Text((data.createdAt ?? '').convertDateStringToAnotherFormat('dd MMMM yyyy'), style: ThemeText.poppinsMedium.copyWith(color: const Color(0xff888888), fontSize: 10),),
              ),
              const SizedBox(width: 5,),
              const Icon(Icons.delete_outlined, color: Color(0xff888888), size: 16,)
            ],
          )
        ],
      ),
    );
  }
}
